class Account < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :owner, class_name: 'User'

end
