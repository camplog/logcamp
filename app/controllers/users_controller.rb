class UsersController < ApplicationController

  def index
    @application = Application.includes(:members).find(params[:application_id])
    @members = @application.members.exclude_users(current_user.id)
  end

  def manage_membership
  	@user        = User.find(params[:user_id])
  	@application = Application.find(params[:application_id])
  	if @application.members.exists?(@user.id)
      @application.members.delete(@user)
    else
      ## TODO
      ## invite user
    end
  end

end
