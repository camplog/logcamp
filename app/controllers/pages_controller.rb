class PagesController < ApplicationController
	skip_before_filter :require_login
  before_action { @render_shared_scripts = true }
  layout 'public'

  def home
  end

  def docs
  end

  def about
  end

end
