module Admin
  class UsersController <  ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    before_action :set_user, only: [:update]

    def index
      @users = current_user.organization.users.where.not(id: current_user.id).all
    end

    def update
      raise "CRAP"
    end

    private

    def set_user
      @user = current_user.organization.users.find(update_user_params[:id])
    end

    def update_user_params
      params.permit(:id)
    end
  end
end
