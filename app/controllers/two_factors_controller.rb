class TwoFactorsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.update \
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true

    redirect_to edit_user_registration_path(current_user)
  end

  def destroy
    current_user.update \
      otp_required_for_login: false

    redirect_to edit_user_registration_path(current_user)
  end
end
