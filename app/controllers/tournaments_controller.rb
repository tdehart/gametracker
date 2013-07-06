class TournamentsController < ApplicationController
  before_filter :admin_user?, except: [:index, :show]
  layout 'single_column', only: [:new]

  def index
    #@tournaments = Tournament.where { start_date >= Date.today }.order { start_date.asc }.page(params[:page]).per(10)
    @tournaments = Tournament.order {start_date.asc }.page(params[:page]).per(10)
  end

  def show
    @tournament = Tournament.find(params[:id])
    @submitter = @tournament.feed_items.where { key == "Tournament.create" }[0].owner
    @events = @tournament.events.order { event_time.asc }
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])

    if @tournament.save
      FeedItem.create!(feedable: @tournament, owner: current_user, key: "Tournament.create")
      redirect_to @tournament
    else
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end


  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      FeedItem.create!(feedable: @tournament, owner: current_user, key: "Tournament.update")
      redirect_to @tournament
    else
      render 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    FeedItem.create!(feedable: @tournament, owner: current_user, key: "Tournament.delete")
    @tournament.destroy
    redirect_to tournaments_path
  end
end
