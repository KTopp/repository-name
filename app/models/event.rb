class Event < ApplicationRecord
  has_many :tickets

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[name location],
                  using: {
                    tsearch: { prefix: true }
                  }
  # validations...
end
