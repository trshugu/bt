class CreateGggs < ActiveRecord::Migration
  def change
    create_table :gggs do |t|
      t.string :nana

      t.timestamps
    end
  end
end
