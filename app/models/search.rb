class Search < ActiveRecord::Base
  DEFAULT_NAME = "Search"
  DEFAULT_COLOR = "black"

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :user


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :name, :color

  def self.create_new_search(keyword, user)
    search = self.new
    search.criteria = keyword
    search.name = DEFAULT_NAME
    search.color = DEFAULT_COLOR
    search.user = user
    search.save

    search.name = "#{DEFAULT_NAME} #{search.id}"
    search.save

    search
  end
end
