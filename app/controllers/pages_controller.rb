class PagesController < ApplicationController
	skip_before_filter :require_login
  layout 'public'

  def home
  end

  def docs
  end

  def about
  end

end
