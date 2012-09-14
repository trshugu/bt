# -*- coding: utf-8 -*-
require './app/helpers/checklinkmodule2ar'

class BookmarksController < ApplicationController
  def index
    @bookmark = Bookmark.new
    
    if (params[:httpcode] == nil)
      @bookmarks = Bookmark.all
    else
      # ngのときは NOT条件 HACK: 
      if params[:httpcode] == "ng"
        query = "httpcode != ?"
      else
        query = "httpcode = ?"
      end
      
      @bookmarks = Bookmark.find(:all, :conditions => [query, "ok"])
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])

    checklink = Checklink.new
    @bookmark.httpcode = checklink.checkuri(@bookmark.uri)
    @bookmark.save

    redirect_to bookmarks_path, notice: '追加しました'
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update_attributes(params[:bookmark])
      redirect_to @bookmark, notice: '更新しました'
    else
      render action: "edit"
    end
  end

  def checklink
    @bookmarks = Bookmark.all
    
    # ブックマーク生存チェック
    countcheckbox = 0
    linkchecker = Checklink.new
    @bookmarks.each do |bookmark|
      countcheckbox += 1
      # HACK:スレッドで処理する
      bookmark.httpcode = linkchecker.checkuri(bookmark.uri)
      bookmark.save
    end
    
    redirect_to bookmarks_path, notice: "チェック完了。"
  end
  
  def deleterecord
    @bookmarks = Bookmark.all
    postparams = Rack::Utils.parse_query(env['rack.request.form_vars'])
    
    deletecount = 0
    @bookmarks.each do |bookmark|
      if (postparams[bookmark.id.inspect + "[delete]"].index("1") != nil)
        bookmark.destroy
        deletecount += 1
      end
    end
    
    message = deletecount.to_s + "件削除しました。"
    
    redirect_to bookmarks_path, notice: message
  end
end
