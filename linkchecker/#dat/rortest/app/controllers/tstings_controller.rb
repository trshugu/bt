class TstingsController < ApplicationController
  # GET /tstings
  # GET /tstings.json
  def index
    @tstings = Tsting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tstings }
    end
  end

  # GET /tstings/1
  # GET /tstings/1.json
  def show
    @tsting = Tsting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tsting }
    end
  end

  # GET /tstings/new
  # GET /tstings/new.json
  def new
    @tsting = Tsting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tsting }
    end
  end

  # GET /tstings/1/edit
  def edit
    @tsting = Tsting.find(params[:id])
  end

  # POST /tstings
  # POST /tstings.json
  def create
    @tsting = Tsting.new(params[:tsting])

    respond_to do |format|
      if @tsting.save
        format.html { redirect_to @tsting, notice: 'Tsting was successfully created.' }
        format.json { render json: @tsting, status: :created, location: @tsting }
      else
        format.html { render action: "new" }
        format.json { render json: @tsting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tstings/1
  # PUT /tstings/1.json
  def update
    @tsting = Tsting.find(params[:id])

    respond_to do |format|
      if @tsting.update_attributes(params[:tsting])
        format.html { redirect_to @tsting, notice: 'Tsting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tsting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tstings/1
  # DELETE /tstings/1.json
  def destroy
    @tsting = Tsting.find(params[:id])
    @tsting.destroy

    respond_to do |format|
      format.html { redirect_to tstings_url }
      format.json { head :no_content }
    end
  end
end
