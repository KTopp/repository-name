User.destroy_all
Event.destroy_all
Ticket.destroy_all

# Helper methods
def random_price
  rand(10..500).to_f
end

def random_ticket_number
  SecureRandom.hex(6).upcase # Generates a random hexadecimal string
end

def random_status
  (Ticket.statuses.keys - ["pending"]).sample # Exclude "pending"
end

def random_category
  Ticket.ticket_categories.keys.sample
end

puts "Creating users..."
# Create 20 users
users = 20.times.map do |i|
  User.create!(
    email: "user#{i+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

puts "Creating events..."
# Create 15 events
events = 15.times.map do |i|
  Event.create!(
    name: Faker::Music::RockBand.name,
    date: Faker::Date.forward(days: rand(30..365)),
    location: Faker::Address.city,
    capacity: rand(50..1000)
  )
end

puts "Creating tickets..."
# Create 3-15 tickets for each event
events.each do |event|
  rand(3..15).times do
    Ticket.create!(
      ticket_number: random_ticket_number,
      price: random_price,
      status: random_status, # Exclude "pending"
      ticket_category: random_category,
      event: event,
      user: users.sample # Assign ticket to a random user
    )
  end
end

puts "Seeding completed!"