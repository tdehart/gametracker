class UsersController < ApplicationController
  before_action :admin_user?, only: [:index, :destroy]
  before_action :signed_in_user, only: [:feed]

  def index
    @users = User.all
  end

  def feed
    @feed_items = current_user.feed.page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    #render :layout => false
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
