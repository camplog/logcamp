class Event < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :application


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :status, :message


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_save :format_fields


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  private

    def format_fields
      self.status = status.downcase
    end

end
