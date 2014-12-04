class Search < ActiveRecord::Base

  # CONSTANTS
  # ------------------------------------------------------------------------------------------------------
  DEFAULT_NAME = 'Search'
  DEFAULT_COLOR = 'black'


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :user, counter_cache: true
  before_validation :set_default_name


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :name, :color


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def self.create_new_search(keyword, user)
    search = self.new
    search.criteria = keyword
    search.user = user
    search.save

    search
  end

  private

  def set_default_name
    self.name ||= "#{DEFAULT_NAME} #{self.class.maximum(:id).to_i + 1}"
    self.color ||= DEFAULT_COLOR
  end
end
