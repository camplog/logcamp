class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :searches,     dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :events,       through: :applications


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email, :full_name
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates_length_of :password, minimum: 6, if: :password
  validates_confirmation_of :password, if: :password


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def email_helper
    "#{full_name} <#{email}>"
  end

  def has_github_account?
  	authentications.github_accounts.any?
  end

  private

    def format_fields
      self.email     = email.downcase
      self.full_name = full_name.titleize
    end

end
