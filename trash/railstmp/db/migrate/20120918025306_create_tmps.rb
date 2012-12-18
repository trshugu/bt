class CreateTmps < ActiveRecord::Migration
  def change
    create_table :tmps do |t|
      t.string :test

      t.timestamps
    end
  end
end
