class Bookmark < ActiveRecord::Base
  attr_accessible :httpcode, :name, :status, :tag, :uri
end
