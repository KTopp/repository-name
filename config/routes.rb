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
  get "/events", to: "events#index"   # this page shows all the events
  get "/events/:id/tickets", to: "tickets#index", as: "event_tickets"   # when you click on an event you go to this page which shows all tickets for sale for an event
  post "/events/:id/tickets", to: "tickets#create"    # there is a form to create a ticket for an event on the individual event page
  
  # ticket routes
  patch "/tickets/:id/pending", to: "tickets#mark_as_pending", as: "pending_ticket"  # on the individual event page each ticket for sale has a button when you click that button it changes the status to pending and adds your user id to the buyer_id
  get "/tickets/cart", to: "tickets#cart", as: "cart"   # in the navbar there is a shopping cart button that when clicked shows me all the tickets where buyer_id = my user_id and status = pending
  patch "/tickets/", to: "tickets#update_sold", as: "sold"          # on the shopping cart page there is a purchased button that when clicked changes the ticket status to sold, changes the buyer_id to nil, and changes the user_id to the current user
  # in the navbar there is a avatar icon that when clicked on takes me to my profile page
  get "tickets/my_listings", to: "tickets#my_listings", as: "my_listings" # on my profile page there is a link to this page that shows all the tickets that have my user_id and the for_sale or pending status
  delete "/tickets/:id", to: "tickets#destroy", as: "delete_ticket"   # on the my_listings page each ticket has a button to delete it
  get "tickets/my_tickets", to: "tickets#my_tickets"    # on the profile page there is a link to a page that shows all of the tickets on my page that shows all the tickets with the current user_id and are sold
  patch "/tickets/:id/sell", to: "tickets#mark_as_for_sale", as: "sell_ticket"   # on the my tickets page each ticket has a button that changes the tickt status to for_sale
end
