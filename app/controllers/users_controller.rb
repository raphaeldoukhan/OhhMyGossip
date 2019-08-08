class UsersController < ApplicationController

    def show 
        @users = User.all
        @index = params[:id]
        @city = City.find(User.find(params[:id]).city_id)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            flash[:notice] = "Création réussie"
            redirect_to '/'
        else
            render new_user_path  
        end 
    end

    def confirm
        @user = User.find(params[:id])
        if @user.confirmation_token == params[:token]
            @user.update_attributes(confirmed: true, confirmation_token: nil)
            @user.save(validate:false)
            session[:auth] = {id: @user.id}
            redirect_to profil_path, success: 'Votre compte a bien été confirmé'
        else
            redirect_to new_user_path, danger: 'ce token ne semble pas valide'
        end
    end

    #  def edit 
    #     @user = User.find(session[:auth]['id'])
    #  end

    # def update
    # end 

    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
