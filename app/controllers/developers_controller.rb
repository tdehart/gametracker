class DevelopersController < ApplicationController
  before_action :admin_user?, except: [:index, :show]
  
  def index
    @developers = Developer.all
  end

  def show
    @developer = Developer.find(params[:id])
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      redirect_to @developer
    else
      render 'new'
    end
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def update
    @developer = Developer.find(params[:id])
    if @developer.update_attributes(developer_params)
      redirect_to @developer
    else
      render 'edit'
    end
  end

  def destroy
    Developer.find(params[:id]).destroy
    redirect_to developers_path
  end

  private
  def developer_params
    params.require(:developer).permit(:name, :website, :image)
  end
end
