class TournamentsController < ApplicationController
  layout 'single_column', only: [:table, :new]

  def index
    @tournaments = Tournament.all
  end

  def table
    respond_to do |format|
      format.html
      format.json { render json: TournamentsDatatable.new(view_context) }
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
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
      redirect_to @tournament
    else
      render 'edit'
    end
  end

  def destroy
    Tournament.find(params[:id]).destroy
    redirect_to tournaments_path
  end
end
