module Ownership
  extend ActiveSupport::Concern

  def is_owner?(user)
    owner.id == user.id
  end

end