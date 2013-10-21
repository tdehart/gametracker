class UsersController < ApplicationController
  before_action :admin_user?, only: [:index, :destroy, :toggle_user]
  before_action :signed_in_user, only: [:feed]
  before_action :correct_user, only: [:update]

  def index
    @users = User.all
  end

  def feed
    @feed_items = Kaminari.paginate_array(current_user.feed.sort! { |a,b| b.created_at <=> a.created_at }).page(params[:page]).per(6)
  end

  def home
    @current_events = Event.current
    @soon_events = Event.soon
    @current_tournaments = Set.new
    @soon_tournaments = Set.new
    @current_events.each { |e| @current_tournaments.add(e.tournament) }
    @soon_events.each { |e| @soon_tournaments.add(e.tournament) }
  end

  def show
    @user = User.find(params[:id])
    @currency = Money::Currency.new(@user.currency_iso_code)
  end

  def new
    @user = User.new
    #render :layout => false
  end

  def edit
    @user = User.find(params[:id])
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    redirect_to users_path
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(update_user_params)
      flash[:success] = "Updated."
      sign_in @user
      redirect_to @user
    else
      render 'show'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  private
  def new_user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:currency_iso_code)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(signin_path) unless current_user?(@user)
  end
end
