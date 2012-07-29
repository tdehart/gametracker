class TournamentsController < ApplicationController
  layout 'single_column', only: [:table, :new]

  def index
    @tournaments = Tournament.soon
  end

  def table
    respond_to do |format|
      format.html
      format.json { render json: TournamentsDatatable.new(view_context) }
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @events = @tournament.events.collect { |e| e if e.valid? }
    #Create a 2-element list that contains all of the event's stream's streamers in the format of [online_name, object]
    @events.each {|e| e["streamers"] = e.stream.streamers.collect { |s| [s.online_name, s] } }
    @tournament.events.build
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      @tournament.events.build
      render 'events'
    else
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end


  def update
    @tournament = Tournament.find(params[:id])
    if params[:tournament][:events_attributes] && @tournament.update_attributes(params[:tournament])
      @tournament.events.build
      render 'events'
    elsif @tournament.update_attributes(params[:tournament])
      redirect_to @tournament
    else #no update
      if params[:tournament][:events_attributes]
        @tournament.events.build
        render 'events'
      else
        render 'edit'
      end
    end
  end

  def destroy
    Tournament.find(params[:id]).destroy
    redirect_to tournaments_path
  end
end
