class EeesController < ApplicationController
  # GET /eees
  # GET /eees.json
  def index
    @eees = Eee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eees }
    end
  end

  # GET /eees/1
  # GET /eees/1.json
  def show
    @eee = Eee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eee }
    end
  end

  # GET /eees/new
  # GET /eees/new.json
  def new
    @eee = Eee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eee }
    end
  end

  # GET /eees/1/edit
  def edit
    @eee = Eee.find(params[:id])
  end

  # POST /eees
  # POST /eees.json
  def create
    @eee = Eee.new(params[:eee])

    respond_to do |format|
      if @eee.save
        format.html { redirect_to @eee, notice: 'Eee was successfully created.' }
        format.json { render json: @eee, status: :created, location: @eee }
      else
        format.html { render action: "new" }
        format.json { render json: @eee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eees/1
  # PUT /eees/1.json
  def update
    @eee = Eee.find(params[:id])

    respond_to do |format|
      if @eee.update_attributes(params[:eee])
        format.html { redirect_to @eee, notice: 'Eee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eees/1
  # DELETE /eees/1.json
  def destroy
    @eee = Eee.find(params[:id])
    @eee.destroy

    respond_to do |format|
      format.html { redirect_to eees_url }
      format.json { head :no_content }
    end
  end
end
