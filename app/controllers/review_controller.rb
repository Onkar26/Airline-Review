class ReviewController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def getAllReviews
        render :json => Review.all
    end

    def authenticationCheck(username)
        Authorization.all.each do |authorization|
            if(authorization.username == username)
                return true
            end
        end

        return false
    end

    # convert stings to integers
    def getReviews
        # airlineID
        id = params[:id].to_i
        reviews = []
        idx = 0
        Review.all.each do |review|
            if(review.airlineID.to_i == id)
                reviews[idx] = review
                idx += 1
            end
        end

        render :json => reviews
    end

    # post request so pass object
    def createReview
        # pass the airlineID from airline model

        # no new review by user and airline

        # add exceptions and test

        if(!authenticationCheck(params[:username]))
            render :json => { "Access" => "required"}
            return
        end


        Review.all.each do |review|
            if(review.airlineID == params[:airlineID] && review.username == params[:username])
                puts "User can give only one review to airline...!"
                render :json => {"Note" => "User can give only one review to airline...!"}
                return
            end
        end

        # puts "hi"
        # puts params[:airlineID]

        # edit airline
        # inside airline airlineID => id
        Airline.all.each do |airline|
            if(airline.id.to_i == params[:airlineID].to_i)
                # integer
                ratingNew = (airline.avgrating.to_f)*(airline.reviewcount.to_f) + params[:rating].to_f
                ratingNew /= (airline.reviewcount.to_i + 1) 
                reviewcountNew = airline.reviewcount.to_i + 1
                airline.update(:avgrating => ratingNew, :reviewcount => reviewcountNew) 
                puts "hello"
                break
            end
            puts "hi"
        end
        reviewItem = {
            "airlineID" => params[:airlineID],
            # "userID" => params[:userID], # after migration
            "username" => params[:username],
            "rating" => params[:rating],
            "heading" => params[:heading],
            "description" => params[:description],
        }
        # edit review
        reviews = Review.new(reviewItem)
        reviews.save
        render :json => reviews
    end

    # put request so pass object
    def editReview

        if(!authenticationCheck(params[:username]))
            render :json => { "Access" => "required"}
            return
        end


        Review.all.each do |review|
            # auto create id 
            # send whole object of review
            if(review.airlineID == params[:airlineID] && review.username == params[:username])
                Airline.all.each do |airline|
                    if(airline.id.to_i == params[:airlineID].to_i)
                        ratingNew = (airline.avgrating.to_f)*(airline.reviewcount.to_f) + params[:rating].to_f - review.rating.to_f
                        ratingNew /= airline.reviewcount.to_i
                        airline.update(:avgrating => ratingNew) 
                        break
                    end
                end
                review.update(:rating => params[:rating], :heading => params[:heading], :description => params[:description]) 
                break
            end
        end
        render :json => Review.all
    end

    # delete request so dont pass object
    def deleteReview
        # review table id

        # if(!authenticationCheck(params[:username]))
        #     render :json => { "Access" => "required"}
        #     return
        # end

        id = params[:id].to_i
        Review.all.each do |review|
            if(review.id == id)
                # edit airline avgrating and reviewcount
                Airline.all.each do |airline|
                    if(airline.id.to_i == review.airlineID.to_i)
                        # integer subtract
                        ratingNew = (airline.avgrating.to_f)*(airline.reviewcount.to_f) - review.rating.to_f
                        # due to lossy conversions it might happen
                        if(ratingNew<=0) 
                            ratingNew = 0
                        end
                        # count must be > 0
                        if((airline.reviewcount.to_i - 1)>0) 
                            ratingNew /= (airline.reviewcount.to_i - 1) 
                        end
                    
                        reviewcountNew = airline.reviewcount.to_i - 1
                        if(reviewcountNew==0) 
                            ratingNew = 0
                        end
                        airline.update(:avgrating => ratingNew, :reviewcount => reviewcountNew) 
                        puts "hello"
                        break
                    end
                    puts "hi"
                end

                Review.all.delete(id)
                break
            end  
        end
        render :json => Review.all
    end

    def deleteReviewAuth
        # review table id

        if(!authenticationCheck(params[:username]))
            render :json => { "Access" => "required"}
            return
        end

        id = params[:id].to_i
        Review.all.each do |review|
            if(review.id == id && review.username == params[:username])
                # edit airline avgrating and reviewcount
                Airline.all.each do |airline|
                    if(airline.id.to_i == review.airlineID.to_i)
                        # integer subtract
                        ratingNew = (airline.avgrating.to_f)*(airline.reviewcount.to_f) - review.rating.to_f
                        # due to lossy conversions it might happen
                        if(ratingNew<=0) 
                            ratingNew = 0
                        end
                        # count must be > 0
                        if((airline.reviewcount.to_i - 1)>0) 
                            ratingNew /= (airline.reviewcount.to_i - 1) 
                        end
                    
                        reviewcountNew = airline.reviewcount.to_i - 1
                        if(reviewcountNew==0) 
                            ratingNew = 0
                        end
                        airline.update(:avgrating => ratingNew, :reviewcount => reviewcountNew) 
                        puts "hello"
                        break
                    end
                    puts "hi"
                end

                Review.all.delete(id)
                break
            end  
        end
        render :json => Review.all
    end


end
