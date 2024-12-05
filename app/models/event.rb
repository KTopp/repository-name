class Event < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[name location],
                  using: {
                    tsearch: { prefix: true }
                  }

  # validations...
  has_many :tickets
end
