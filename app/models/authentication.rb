class Authentication < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
	belongs_to :user


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :github,    -> { where(provider: 'github') }
  scope :centralid, -> { where(provider: 'centralid') }


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

end
