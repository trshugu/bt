class Bookmark < ActiveRecord::Base
  attr_accessible :httpcode, :status, :tag, :title, :uri
end
