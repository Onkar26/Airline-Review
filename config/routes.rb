Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/airlines", to: "airlines#getAirlines"
  post "/airlines", to: "airlines#createAirline"

  # pass airline id
  get "/review/:id", to: "review#getReviews" # optional to 2nd get of airlines
  get "/review", to: "review#getAllReviews"
  post "/review", to: "review#createReview"
  put "/review", to: "review#editReview"
  # review table/model id
  delete "/review/:id", to: "review#deleteReview"
  post "/review/delete", to: "review#deleteReviewAuth" # delete using authenticationCheck

  get "/users", to: "users#getUsers"
  post "/users/forgot", to: "users#forgot_password"
  post "/users", to: "users#createUser"
  put "/users", to: "users#editUser" # not developed yet
  #  from log in table id
  delete "/users/:id", to: "users#deleteUser" # not used yet need to map all the tables accordingly

  # Defines the root path route ("/")
  # root "articles#index"

  get "/users/logins", to: "users#getAuthorizations"
  post "/users/authenticate", to: "users#authentication" # {username, password} 
  # send authorization table id 
  delete "/users/logout/:id", to: "users#logout"

  get "/favourites", to: "favourites#getFavourites"
  # send username, airlineID
  post "/favourites", to: "favourites#addToFavourites"
  # send username, airlineID
  delete "/favourites/:id", to: "favourites#deleteFavourite"

end
