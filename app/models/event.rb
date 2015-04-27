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
                  ignoring: :accents,
                  order_within_rank: "events.date DESC"
                  # Fix for PG order_by and pagination
                  # https://github.com/Casecommons/pg_search#order_within_rank-breaking-ties


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :application


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :status, :message


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :set_date
  before_save   :format_fields
  after_save    :sync_keywords


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def formatted_date
    event_date = date.present? ? date : created_at
    event_date < 1.day.ago ? event_date.strftime("%d/%m %H:%M") : event_date.strftime("%H:%M")
  end

  private

    def format_fields
      self.status = status.downcase
    end

    def set_date
      self.date = Time.zone.now unless date.present?
    end

    def sync_keywords
      # keywords are meant to loosen search results
      keywords = []
      keywords << date.present? ? self.date.strftime("%d/%m/%Y") : Time.zone.now.strftime("%d/%m/%Y")
      keywords << application.name.downcase.to_s
      self.keywords = keywords.join(", ")
    end
end
