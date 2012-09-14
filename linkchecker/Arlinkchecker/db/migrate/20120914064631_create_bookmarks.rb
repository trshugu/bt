class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :uri
      t.string :tag
      t.string :status
      t.string :httpcode

      t.timestamps
    end
  end
end
