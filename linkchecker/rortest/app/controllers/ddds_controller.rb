class DddsController < ApplicationController
  # GET /ddds
  # GET /ddds.json
  def index
    @ddds = Eee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ddds }
    end
  end

  # GET /ddds/1
  # GET /ddds/1.json
  def show
    @ddd = Eee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ddd }
    end
  end

  # GET /ddds/new
  # GET /ddds/new.json
  def new
    @ddd = Eee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ddd }
    end
  end

  # GET /ddds/1/edit
  def edit
    @ddd = Eee.find(params[:id])
  end

  # POST /ddds
  # POST /ddds.json
  def create
    @ddd = Eee.new(params[:ddd])

    respond_to do |format|
      if @Eee.save
        format.html { redirect_to @ddd, notice: 'ddd was successfully created.' }
        format.json { render json: @ddd, status: :created, location: @ddd }
      else
        format.html { render action: "new" }
        format.json { render json: @ddd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ddds/1
  # PUT /ddds/1.json
  def update
    @ddd = Eee.find(params[:id])

    respond_to do |format|
      if @ddd.update_attributes(params[:ddd])
        format.html { redirect_to @ddd, notice: 'ddd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ddd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ddds/1
  # DELETE /ddds/1.json
  def destroy
    @ddd = Eee.find(params[:id])
    @ddd.destroy

    respond_to do |format|
      format.html { redirect_to ddds_url }
      format.json { head :no_content }
    end
  end
end
