Ticket.destroy_all
User.destroy_all
Event.destroy_all


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
REAL_CITIES = [
  # Colombia
  'Bogotá, Teatro Colón',
  'Medellín, Estadio Atanasio Girardot',
  'Cali, Auditorio La Tertulia',
  'Barranquilla, Sala Luneta 50',
  'Cartagena, Centro de Convenciones',
  'Bucaramanga, Teatro Santander',
  'Pereira, Café Bar Kamala',
  'Manizales, Centro Cultural Universitario',
  'Santa Marta, Plaza Mayor',
  'Villavicencio, Parque Las Malocas',

  # México
  'Ciudad de México, Auditorio Nacional',
  'Guadalajara, Teatro Diana',
  'Monterrey, Arena Monterrey',
  'Cancún, Coco Bongo',
  'Tijuana, Black Box',
  'Puebla, Auditorio Metropolitano',
  'Querétaro, La Glotonería',
  'León, Poliforum León',
  'Mérida, Foro GNP',
  'San Luis Potosí, Teatro de la Paz',

  # Argentina
  'Buenos Aires, Luna Park',
  'Córdoba, Plaza de la Música',
  'Rosario, Metropolitano Rosario',
  'Mendoza, Auditorio Ángel Bustelo',
  'La Plata, Teatro Coliseo Podestá',
  'Mar del Plata, Centro Cultural Estación Terminal Sur',
  'Salta, Teatro Provincial',
  'San Juan, Espacio San Juan Shopping',
  'San Miguel de Tucumán, Teatro Mercedes Sosa',
  'Bariloche, Camping Musical Bariloche'
]
bands = [
  "The Beatles",
  "Queen",
  "Led Zeppelin",
  "The Rolling Stones",
  "Pink Floyd",
  "Nirvana",
  "The Who",
  "AC/DC",
  "Metallica",
  "U2",
  "Radiohead",
  "Foo Fighters",
  "The Doors",
  "Green Day",
  "The Clash"
]
events = 15.times.map do |i|
  Event.create!(
    name: bands.sample,
    date: Faker::Date.forward(days: rand(30..365)),
    location: REAL_CITIES.sample,
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
