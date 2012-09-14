class CreateTstings < ActiveRecord::Migration
  def change
    create_table :tstings do |t|
      t.string :aaa
      t.int :bbb
      t.string :ccc

      t.timestamps
    end
  end
end
