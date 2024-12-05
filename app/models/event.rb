class Event < ApplicationRecord
  has_many :tickets
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def geocode
    super
    if latitude.nil? || longitude.nil?
      Rails.logger.warn "Geocoding failed for Event: #{location}"
    end
  end

  # validations...
end
