class AirlinesController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def getAirlines
        render :json => Airline.all
    end

    # def getReviewDetails

    # end

    def createAirline
        airlineItem = {
            "name" => params[:name],
            "img" => params[:img],
            "avgrating" => params[:avgrating],
            "reviewcount" => params[:reviewcount],
        }
        airline = Airline.new(airlineItem)
        airline.save
        render :json => airline
    end

    # def editAirline

    # end

end
