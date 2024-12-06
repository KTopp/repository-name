class Event < ApplicationRecord
  has_many :tickets
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[name location],
                  using: {
                    tsearch: { prefix: true }
                  }

  def geocode
    super
    if latitude.nil? || longitude.nil?
      Rails.logger.warn "Geocoding failed for Event: #{location}"
    end
  end
end
