class TmpsController < ApplicationController
  # GET /tmps
  # GET /tmps.json
  def index
    @tmps = Tmp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tmps }
    end
  end

  # GET /tmps/1
  # GET /tmps/1.json
  def show
    @tmp = Tmp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tmp }
    end
  end

  # GET /tmps/new
  # GET /tmps/new.json
  def new
    @tmp = Tmp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tmp }
    end
  end

  # GET /tmps/1/edit
  def edit
    @tmp = Tmp.find(params[:id])
  end

  # POST /tmps
  # POST /tmps.json
  def create
    @tmp = Tmp.new(params[:tmp])
    if (params[:test] != nil)
      @tmp.test = params[:test]
    end

    respond_to do |format|
      if @tmp.save
        format.html { redirect_to @tmp, notice: 'Tmp was successfully created.' }
        format.json { render json: @tmp, status: :created, location: @tmp }
      else
        format.html { render action: "new" }
        format.json { render json: @tmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tmps/1
  # PUT /tmps/1.json
  def update
    @tmp = Tmp.find(params[:id])

    respond_to do |format|
      if @tmp.update_attributes(params[:tmp])
        format.html { redirect_to @tmp, notice: 'Tmp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tmps/1
  # DELETE /tmps/1.json
  def destroy
    @tmp = Tmp.find(params[:id])
    @tmp.destroy

    respond_to do |format|
      format.html { redirect_to tmps_url }
      format.json { head :no_content }
    end
  end
end
