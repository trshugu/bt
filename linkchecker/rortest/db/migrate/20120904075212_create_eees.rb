class CreateEees < ActiveRecord::Migration
  def change
    create_table :eees do |t|
      t.string :name

      t.timestamps
    end
  end
end
