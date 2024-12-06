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

  validates :location, presence: true
  validates :date, presence: true
  validates :date, uniqueness: { scope: :name }
  validates :name, presence: true
  validates :name, uniqueness: { scope: :date }
  validates :capacity, presence: true

  def geocode
    super
    return unless latitude.nil? || longitude.nil?

    Rails.logger.warn "Geocoding failed for Event: #{location}"
  end
end
