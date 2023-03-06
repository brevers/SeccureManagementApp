module Admin
  class UsersController <  ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    before_action :set_user, only: [:update]

    def index
      @users = current_user.organization.users.where.not(id: current_user.id).all
    end

    def update
      if @user.update role: User.roles[update_user_params[:role]]
         redirect_to action: :index, notice: "User was successfully updated."
      else
         redirect_to action: :index, alert: "Failed to update user."
      end
    end

    private

    def set_user
      @user = current_user.organization.users.find(update_user_params[:id])
    end

    def update_user_params
      params.permit(:id, :role)
    end
  end
end
