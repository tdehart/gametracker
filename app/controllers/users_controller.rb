class UsersController < ApplicationController
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
      #TODO: Add flash message when signed in
      redirect_to tournaments_path
    else
      render 'new'
    end
  end
end
