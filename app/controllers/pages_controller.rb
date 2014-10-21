class PagesController < ApplicationController
  layout 'public', only: [:home]

  def home

  end

  def docs
  end
end
