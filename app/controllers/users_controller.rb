class UsersController < ApplicationController
	before_action :add_abilities

  def index
    @application = Application.includes(:members).find(params[:application_id])
    @members = @application.members.exclude_users(current_user.id)
    redirect_to feed_path unless can?(current_user, :read_application, @application)
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

    respond_to do |format|
      format.html { redirect_to feed_path unless can?(current_user, :manage_application, @application) }
      format.js { redirect_to feed_path unless can?(current_user, :manage_application, @application) }
    end
  end

  private

    def add_abilities
      abilities << Application
    end

end
