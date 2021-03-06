class ApplicationController < ActionController::Base
protect_from_forgery with: :exception

before_action :only_signed_in

add_flash_types :success, :danger

private 

    def only_signed_in
        if !session[:user_id]
            redirect_to new_session_path
        end
    end

    def only_author
        if session[:user_id] == Gossip.find(params[:id]).user.id
        else  redirect_to gossip_path
        end
    end
end    

