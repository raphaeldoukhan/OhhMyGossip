class HomeController < ApplicationController

    skip_before_action :only_signed_in


    def index
        @gossips = Gossip.all
        @users = User.all
    end
end
