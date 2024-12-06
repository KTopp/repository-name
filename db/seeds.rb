require 'open-uri'

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
event1 = Event.new(
  name: "The Beatles",
  date: "2023-08-15",
  location: "Liverpool, England",
  capacity: 100
)
file1 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733441074/GOGOGO/gkqhzdzzjfphics4zww1.jpg")
event1.photo.attach(io: file1, filename: "beatles.jpg", content_type: "image/png")
event1.save

event2 = Event.new(
  name: "Billie Eilish",
  date: "2023-09-25",
  location: "Los Angeles, USA",
  capacity: 200
)
file2 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515631/GOGOGO/ouw6bcgybuqamrcsnj6g.jpg")
event2.photo.attach(io: file2, filename: "billie_eilish.jpg", content_type: "image/png")
event2.save

event3 = Event.new(
  name: "Drake",
  date: "2023-10-10",
  location: "Toronto, Canada",
  capacity: 250
)
file3 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515632/GOGOGO/rv1b98owaaecjw9qwdaz.jpg")
event3.photo.attach(io: file3, filename: "drake.jpg", content_type: "image/png")
event3.save

event4 = Event.new(
  name: "Bad Bunny",
  date: "2023-11-05",
  location: "San Juan, Puerto Rico",
  capacity: 300
)
file4 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515631/GOGOGO/wmqed8q9rle4ijg3mgq1.jpg")
event4.photo.attach(io: file4, filename: "bad_bunny.jpg", content_type: "image/png")
event4.save

event5 = Event.new(
  name: "Ariana Grande",
  date: "2023-07-20",
  location: "Boca Raton, USA",
  capacity: 150
)
file5 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515631/GOGOGO/ucpqwh4io5bvgjvo9ozz.jpg")
event5.photo.attach(io: file5, filename: "ariana_grande.jpg", content_type: "image/png")
event5.save

event6 = Event.new(
  name: "The Weeknd",
  date: "2023-09-18",
  location: "Toronto, Canada",
  capacity: 220
)
file6 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515632/GOGOGO/xqm26axrg60iq3z8beev.webp")
event6.photo.attach(io: file6, filename: "the_weeknd.jpg", content_type: "image/png")
event6.save

event7 = Event.new(
  name: "Travis Scott",
  date: "2023-12-01",
  location: "Houston, USA",
  capacity: 250
)
file7 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515632/GOGOGO/zwnnvdrh9som2ofbjgbu.jpg")
event7.photo.attach(io: file7, filename: "travis_scott.jpg", content_type: "image/png")
event7.save

event8 = Event.new(
  name: "Kendrick Lamar",
  date: "2023-10-05",
  location: "Compton, USA",
  capacity: 180
)
file8 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515631/GOGOGO/isuus0l7byottqelfiey.jpg")
event8.photo.attach(io: file8, filename: "kendrick_lamar.jpg", content_type: "image/png")
event8.save

event9 = Event.new(
  name: "Lizzo",
  date: "2023-11-10",
  location: "Detroit, USA",
  capacity: 200
)
file9 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515631/GOGOGO/zzvz5xn9mzqtl9enadzp.webp")
event9.photo.attach(io: file9, filename: "lizzo.jpg", content_type: "image/png")
event9.save

event10 = Event.new(
  name: "Shakira",
  date: "2023-12-15",
  location: "Barranquilla, Colombia",
  capacity: 280
)
file10 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515631/GOGOGO/kbyqdxqsr9f2lt8dmrkp.jpg")
event10.photo.attach(io: file10, filename: "shakira.jpg", content_type: "image/png")
event10.save

event11 = Event.new(
  name: "Ed Sheeran",
  date: "2023-08-30",
  location: "Halifax, England",
  capacity: 180
)
file11 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515923/GOGOGO/nz8iyyjvibycauuwzhdt.jpg")
event11.photo.attach(io: file11, filename: "ed_sheeran.jpg", content_type: "image/png")
event11.save

event12 = Event.new(
  name: "Beyoncé",
  date: "2023-09-12",
  location: "Houston, USA",
  capacity: 220
)
file12 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515923/GOGOGO/qynzmihdrsxjwobfulro.jpg")
event12.photo.attach(io: file12, filename: "beyonce.jpg", content_type: "image/png")
event12.save

event13 = Event.new(
  name: "Harry Styles",
  date: "2023-10-18",
  location: "Redditch, England",
  capacity: 200
)
file13 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515923/GOGOGO/exdv1auy26qfp877gual.jpg")
event13.photo.attach(io: file13, filename: "harry_styles.jpg", content_type: "image/png")
event13.save

event14 = Event.new(
  name: "Lil Nas X",
  date: "2023-11-25",
  location: "Atlanta, USA",
  capacity: 180
)
file14 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733516162/GOGOGO/kel0hddsfp3kwd9nq5tk.jpg")
event14.photo.attach(io: file14, filename: "lil_nas_x.jpg", content_type: "image/png")
event14.save

event15 = Event.new(
  name: "Post Malone",
  date: "2023-12-10",
  location: "Syracuse, USA",
  capacity: 250
)
file15 = URI.open("https://res.cloudinary.com/drchz58yw/image/upload/v1733515923/GOGOGO/bfmor11abywfltzadj4r.jpg")
event15.photo.attach(io: file15, filename: "post_malone.jpg", content_type: "image/png")
event15.save

events = [event1, event2, event3, event4, event5, event6, event7, event8, event9, event10, event11, event12, event13, event14, event15]


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
