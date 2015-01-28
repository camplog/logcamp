class Application < ActiveRecord::Base
	include Sluggable
  include Ownership

	# ASSOCIATIONS
	# ------------------------------------------------------------------------------------------------------
	belongs_to              :owner,   class_name: 'User', counter_cache: true
  has_and_belongs_to_many :members, class_name: 'User'
	has_many                :events,  dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }


	# VALIDATIONS
	# ------------------------------------------------------------------------------------------------------
	validates_presence_of :name
	validates_uniqueness_of :name


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create  :format_fields
  after_create   :add_owner_as_member
  before_destroy { members.clear }


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def is_owner?(user)
    owner == user
  end

  private

  def format_fields
  	self.auth_token = SecureRandom.hex
    self.identicon  = Identicon.data_url_for name, 128, [255, 255, 255]
  end

  def self.allowed(object, subject)
    rules = []
    return rules unless subject.instance_of?(Application)
    rules << :read_application if subject.members.exists?(object.id)
    rules << :manage_application if subject.owner == object
    rules
  end

  def add_owner_as_member
    members << owner
  end
end
