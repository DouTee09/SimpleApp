class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])

    if @user&.can_be_activated?(params[:id])
      activate_user
      log_in @user
      flash[:success] = "Account activated !"
      redirect_to @user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private
    def activate_user
      @user.update(activated: true, activated_at: Time.zone.now)
    end
end
#note: Tìm hiểu lại về biến....
