class WebResourcesController < ApplicationController
  # GET /web_resources
  # GET /web_resources.json
  def index
    @web_resources = WebResource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @web_resources }
    end
  end

  # GET /web_resources/1
  # GET /web_resources/1.json
  def show
    @web_resource = WebResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @web_resource }
    end
  end

  # GET /web_resources/new
  # GET /web_resources/new.json
  def new
    @web_resource = WebResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @web_resource }
    end
  end

  # GET /web_resources/1/edit
  def edit
    @web_resource = WebResource.find(params[:id])
  end

  # POST /web_resources
  # POST /web_resources.json
  def create
    @web_resource = WebResource.new(params[:web_resource])

    respond_to do |format|
      if @web_resource.save
        format.html { redirect_to @web_resource, notice: 'Web resource was successfully created.' }
        format.json { render json: @web_resource, status: :created, location: @web_resource }
      else
        format.html { render action: "new" }
        format.json { render json: @web_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /web_resources/1
  # PUT /web_resources/1.json
  def update
    @web_resource = WebResource.find(params[:id])

    respond_to do |format|
      if @web_resource.update_attributes(params[:web_resource])
        format.html { redirect_to @web_resource, notice: 'Web resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_resources/1
  # DELETE /web_resources/1.json
  def destroy
    @web_resource = WebResource.find(params[:id])
    @web_resource.destroy

    respond_to do |format|
      format.html { redirect_to web_resources_url }
      format.json { head :no_content }
    end
  end
end
