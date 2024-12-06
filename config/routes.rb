Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  # event routes
  get "/events", to: "events#index", as: "events"   # this page shows all the events
  get "/events/new", to:"events#new", as: "new_event" # this page renders the form for a new event
  post "/events", to:"events#create"                  # this route creates the post request to create a new event
  get "/events/:id/edit", to: "events#edit", as: "edit_event" # this route renders the form to edit an event
  patch "/events/:id", to: "events#update", as: "update_event"
  get "/events/:id/tickets", to: "tickets#index", as: "event_tickets"   # when you click on an event you go to this page which shows all tickets for sale for an event
  get "events/:id/tickets/new", to: "tickets#new", as: "new_ticket"  # there is a button on the event_tickets page that takes you to a form to make a new ticket
  post "/events/:id/tickets", to: "tickets#create"    # this creates a new ticket when you hit submit
  
  # ticket routes
  patch "/tickets/:id/pending", to: "tickets#mark_as_pending", as: "pending_ticket"  # on the individual event page each ticket for sale has a button when you click that button it changes the status to pending and adds your user id to the buyer_id
  get "/tickets/cart", to: "tickets#cart", as: "cart"   # in the navbar there is a shopping cart button that when clicked shows me all the tickets where buyer_id = my user_id and status = pending
  patch "/tickets/:id/cancel", to: "tickets#cancel", as: "cancel"  # in the cart you can cancel individual tickets to remove them from the cart
  patch "/tickets/", to: "tickets#mark_as_sold", as: "sold"          # on the shopping cart page there is a purchased button that when clicked changes the ticket status to sold, changes the buyer_id to nil, and changes the user_id to the current user
  # in the navbar there is a avatar icon that when clicked on takes me to my profile page
  get "tickets/my_listings", to: "tickets#my_listings", as: "my_listings" # on my profile page there is a link to this page that shows all the tickets that have my user_id and the for_sale or pending status
  get "/tickets/:id/edit", to: "tickets#edit", as: "edit_ticket"  # on my listings page you can click a button on any of the tickets to edit its price this button takes you to an edit page
  patch "/tickets/:id", to: "tickets#update", as: "update_ticket" # when you hit submit on the edit page it updates the tickets price and redirects to my listings
  patch "/tickets/:id/stop", to: "tickets#stop", as: "stop"   # I don't think you want to delete tickets.. just stop selling them...
  # delete "/tickets/:id", to: "tickets#destroy", as: "delete_ticket"   # on the my_listings page each ticket has a button to delete it
  get "tickets/my_tickets", to: "tickets#my_tickets", as: "my_tickets"    # on the profile page there is a link to a page that shows all of the tickets on my page that shows all the tickets with the current user_id and are sold
  patch "/tickets/:id/sell", to: "tickets#mark_as_for_sale", as: "sell_ticket"   # on the my tickets page each ticket has a button that changes the tickt status to for_sale
  get "tickets/:id/", to: "tickets#show", as: "show"   # on the tickets page each ticket has a button that takes you to the ticket view page
end
