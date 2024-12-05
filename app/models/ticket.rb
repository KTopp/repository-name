class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user

  enum ticket_category: { vip: 0, general_admission: 1, balcony: 2, early_bird: 3 }
  enum :status { for_sale: 0, pending: 1, sold: 2 }

  validates :ticket_category, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :ticket_number, uniqueness: true, presence: true
end
