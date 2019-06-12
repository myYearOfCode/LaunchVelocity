class CurrentUsersController < ApplicationController

    def get_current_user
        render json: current_user
    end

end
