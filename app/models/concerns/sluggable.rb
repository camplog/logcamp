module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :format_slug
  end

  def format_slug
    self.slug = I18n.transliterate(slug.present? ? slug : name).parameterize.downcase
  end
end