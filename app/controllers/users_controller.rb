class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :show]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :user_role_delete, only: :destroy

  def index
    @users = User.activated.page(params[:page]).per(20)
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per(15)
    @comment = Comment.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find params[:id]
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def user_role_delete
    redirect_to(root_url) unless current_user.admin? || current_user?(@user)
  end
end
