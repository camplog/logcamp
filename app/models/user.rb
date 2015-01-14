class User < ActiveRecord::Base
  authenticates_with_sorcery!

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  TOKEN_LENGTH = 32
  PWD_DEFAULT_LENGTH = 8

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_one  :account,      foreign_key: 'owner_id', dependent: :destroy
  has_many :searches,     dependent: :destroy
  has_and_belongs_to_many :applications
  has_many :events,       through: :applications


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :exclude_users, ->(user_ids) { where("id NOT IN (?)", user_ids) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email, :full_name
  validates_uniqueness_of :email
  validates_format_of :email, with: EMAIL_FORMAT
  validates_length_of :password, minimum: 6, if: :password
  validates_confirmation_of :password, if: :password


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create  :format_fields
  after_create   { create_account }
  before_destroy { applications.clear }


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def email_helper
    "#{full_name} <#{email}>"
  end

  def signed_up_with_github?
  	authentications.github.any?
  end

  def signed_up_with_centralid?
    authentications.centralid.any?
  end

  def active?
    activation_state == 'active' && activation_token == nil
  end

  private

  def format_fields
    self.email     = email.downcase if email.present?
    self.full_name = full_name.titleize if full_name.present?
  end

  # Central ID OAuth
  def self.create_with_omniauth(auth)
    # Check if user already exists
    # If so, let's update it instead of creating new record
    # since we have uniqueness constraints on db columns
    case User.find_by(email: auth['info']['email'])
    when exists?
      user.authentications.create!(
        provider: auth['provider'],
        uid:      auth['uid']
      )
    else
      user = create! do |user|
        user.full_name   = auth['info']['name']
        user.email       = auth['info']['email']
        user.password    = SecureRandom.hex
        user.authentications.new(
          provider: auth['provider'],
          uid:      auth['uid']
        )
      end
      # Activate user manually since Sorcery defaults to 'pending'
      user.update_attributes(activation_state: 'active', activation_token: nil)
    end
    UserMailer.welcome(user).deliver_later
    user
  end
end
