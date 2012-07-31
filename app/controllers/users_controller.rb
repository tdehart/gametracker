class UsersController < ApplicationController
  before_filter :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def feed
    @feed_items = current_user.feed
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    #render :layout => false
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
