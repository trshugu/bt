class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.all
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.json
  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  # GET /bookmarks/1/tide
  def tide
    @bookmark = Bookmark.find(params[:id])
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(params[:bookmark])

    require './app/helpers/checklinkmodule2ar'
    linkchecker = Checklink.new
    @bookmark.httpcode = linkchecker.checkuri(@bookmark.uri)
    @bookmark.save

    respond_to do |format|
      if @bookmark.save
        #format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully created.' }
        format.json { render json: @bookmark, status: :created, location: @bookmark }
      else
        format.html { render action: "new" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url }
      format.json { head :no_content }
    end
  end

  # POST /bookmarks/1
  # POST /bookmarks/1.json
  def checklink
    @bookmarks = Bookmark.all
    
    require './app/helpers/checklinkmodule2ar'
    linkchecker = Checklink.new
    countcheckbox = 0

    @bookmarks.each do |bookmark|
      countcheckbox += 1
      #bookmark.httpcode = linkchecker.checkuri(bookmark.uri)
      bookmark.save
    end
    
    redirect_to bookmarks_path, notice: countcheckbox
#    respond_to do |format|
#      if @bookmark.save
#        #format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
#        format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully created.' }
#        format.json { render json: @bookmark, status: :created, location: @bookmark }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
#      end
#    end
  end
  
  def deleterecord
    @bookmarks = Bookmark.all
    poster = Rack::Utils.parse_query(env['rack.request.form_vars'])
    
    @bookmarks.each do |bookmark|
      if (poster[bookmark.id.inspect + "[delete]"].index("1") != nil)
        bookmark.destroy
      end
    end
    
    redirect_to bookmarks_path, notice: poster
  end
end
