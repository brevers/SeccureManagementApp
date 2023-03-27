module Admin
  class UsersController <  ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    before_action :set_user, only: [:update]

    def index
      @users = current_user.organization.users.where.not(id: current_user.id).all
    end

    def update
      respond_to do |format|
        if @user.update role: User.roles[params[:user][:role]]
          format.html {
            redirect_to admin_users_path(current_user), notice: "The user's role was updated"
          }
        else
          format.html {
            redirect_to admin_users_path(current_user), notice: "Failed to update user's role"
          }
        end
      end
    end

    private

    def set_user
      @user = current_user.organization.users.find(update_user_params[:id])
    end

    def update_user_params
      params.require(:user).permit(:id)
    end
  end
end
