class Application < ActiveRecord::Base
	include Sluggable

	# ASSOCIATIONS
	# ------------------------------------------------------------------------------------------------------
	belongs_to :user
	has_many :events, dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }


	# VALIDATIONS
	# ------------------------------------------------------------------------------------------------------
	validates_presence_of :name
	validates_uniqueness_of :name


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  private

    def format_fields
    	self.auth_token  = SecureRandom.hex
      self.identicon   = Identicon.data_url_for name, 128, [255, 255, 255]
    end

end
