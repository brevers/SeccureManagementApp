module Admin
  class DashboardController <  ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    def index
    end
  end
end
