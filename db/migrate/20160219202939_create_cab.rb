class CreateCab < ActiveRecord::Migration
  def change
    create_table :cabs do |t|
      t.string :cab_type
      t.integer :location_x
      t.integer :location_y
      t.string  :status
      t.belongs_to :customer, index: true
    end
  end
end
