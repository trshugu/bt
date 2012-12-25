class GggsController < ApplicationController
  # GET /gggs
  # GET /gggs.json
  def index
    @gggs = Ggg.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gggs }
    end
  end

  # GET /gggs/1
  # GET /gggs/1.json
  def show
    @ggg = Ggg.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ggg }
    end
  end

  # GET /gggs/new
  # GET /gggs/new.json
  def new
    @ggg = Ggg.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ggg }
    end
  end

  # GET /gggs/1/edit
  def edit
    @ggg = Ggg.find(params[:id])
  end

  # POST /gggs
  # POST /gggs.json
  def create
    @ggg = Ggg.new(params[:ggg])

    respond_to do |format|
      if @ggg.save
        format.html { redirect_to @ggg, notice: 'Ggg was successfully created.' }
        format.json { render json: @ggg, status: :created, location: @ggg }
      else
        format.html { render action: "new" }
        format.json { render json: @ggg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gggs/1
  # PUT /gggs/1.json
  def update
    @ggg = Ggg.find(params[:id])

    respond_to do |format|
      if @ggg.update_attributes(params[:ggg])
        format.html { redirect_to @ggg, notice: 'Ggg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ggg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gggs/1
  # DELETE /gggs/1.json
  def destroy
    @ggg = Ggg.find(params[:id])
    @ggg.destroy

    respond_to do |format|
      format.html { redirect_to gggs_url }
      format.json { head :no_content }
    end
  end
end
