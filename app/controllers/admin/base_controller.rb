class Admin::BaseController < ApplicationController

	before_action :check_admin

	private

	  def check_admin
	  	current_user && current_user.admin?
	  end
end
