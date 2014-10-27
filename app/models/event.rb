class Event < ActiveRecord::Base

  # SEARCH
  # ------------------------------------------------------------------------------------------------------
  # PgSearch::Multisearch.rebuild(Event)
  # rake pg_search:multisearch:rebuild[Event]
  include PgSearch
  pg_search_scope :search_by_keyword,
                  against: [:status, :message, :metadata, :keywords],
                  using: {
                    tsearch: {
                      prefix: true # match any characters
                    }
                  },
                  ignoring: :accents


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :application


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :status, :message


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_save  :format_fields, :sync_keywords
  # after_create :notify_members


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def notify_members
    EventMailer.notify_members(self).deliver_later if alert?
  end

  private

    def format_fields
      self.status = status.downcase
    end

    def sync_keywords
      # keywords are meant to loosen search results
      keywords = []
      keywords << Time.zone.now.strftime("%d/%m/%Y")
      keywords << self.application.name.downcase.to_s
      self.keywords = keywords.join(", ")
    end

end
