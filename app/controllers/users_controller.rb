class UsersController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def getUsers
        render :json => UserLogIn.all
    end

    def forgot_password
        UserLogIn.all.each do |user|
            if(user.username == params[:username] && user.contact == params[:contact])
                render :json => {"Message" => "Password is sent to your contact...","password" => user.password}
                return
            end 
        end
        render :json => {"password" => "Incorrect credentials...!"}
    end

    def createUser
        userItem = {
            "username" => params[:username],
            "password" => params[:password],
            "contact" => params[:contact],
        }
        users = UserLogIn.new(userItem)
        users.save
        render :json => {"Action" => "Account has been created successfully"}
    end

    # in this case user cannot be deleted

    def deleteUser
        # user_log_in table id
        id = params[:id].to_i
        # also delete authorization 
        UserLogIn.all.each do |user|
            if(user.id == id)
                Authorization.all.each do |authorization|
                    if(authorization.username == user.username)
                        Authorization.all.delete(authorization.id)
                    end
                end
                # Review.all.each do |review|
                #     if(review.userID == id)
                #         # edit airline avgrating and reviewcount
                #         Airline.all.each do |airline|
                #             if(airline.userID.to_i == id)
                #                 ratingNew = (airline.avgrating.to_i)*(airline.reviewcount.to_i) - review.rating.to_i
                #             end
                #             # due to lossy conversions it might happen
                #             if(ratingNew<0) 
                #                 ratingNew = 0
                #             end
                #             # count must be > 0
                #             if((airline.reviewcount.to_i - 1)>0) 
                #                 ratingNew /= (airline.reviewcount.to_i - 1) 
                #             end
                #             reviewcountNew = airline.reviewcount.to_i - 1
                #             airline.update(:avgrating => ratingNew, :reviewcount => reviewcountNew) 
                #             puts "hello"
                #             break
                #         end
                #         Review.all.delete(review.id)
                #         break
                #     end  
                # end

                UserLogIn.all.delete(id)
                break
            end  
        end
        render :json => UserLogIn.all
    end

    def authentication
        UserLogIn.all.each do |user|
            if(user.username == params[:username] && user.password == params[:password])
                Authorization.all.each do |authorization|
                    if(authorization.username == params[:username])
                        render :json => {"Access" => "You are already Logged In", "id" => 0}
                        return
                    end
                end
                authItem = {
                    "username" => params[:username],
                    "status" => "Logged In", # starus
                }
                auth = Authorization.new(authItem)
                auth.save 
                render :json => {"Access" => "You have been authenticated successfully", "id" => auth.id}
                return
            end
        end

        render :json => {"Access" => "Wrong username or password", "id" => -1}

    end

    def logout
        # authorization table id
        id = params[:id]
        Authorization.all.each do |authorization|
            if(authorization.id.to_i == params[:id].to_i)
                Authorization.all.delete(id)
            end
        end
        render :json => Authorization.all 
    end

    def getAuthorizations
        render :json => Authorization.all
    end
end
