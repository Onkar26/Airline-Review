class FavouritesController < ActionController::Base

    skip_before_action :verify_authenticity_token

    # Favourite : {userID, airlineID}
    def getFavourites
        render :json => Favourite.all
    end

    def addToFavourites
        # valid for unique username
        username = params[:username]
        airlineID = params[:airlineID]
        UserLogIn.all.each do |user|
            if(user.username == username)
                favouriteItem = {
                    "userID" => user.id,
                    "airlineID" => airlineID,
                }
                favourite = Favourite.new(favouriteItem)
                favourite.save
                render :json => {"data" => "Success...!"}
                return
            end
        end
    end

    def deleteFavourite
        username = params[:username]
        airlineID = params[:airlineID]
        UserLogIn.all.each do |user|
            if(user.username === username)
                Favourite.all.each do |favo|
                    # compare integers if they are string form of int
                    if(favo.userID.to_i === user.id.to_i && favo.airlineID.to_i === airlineID.to_i)
                        favo.destroy
                        # render :json => {"data" => "Success...!"}
                    end
                end
            end
        end
        render :json => {"data" => "Success...!"}
    end

end
