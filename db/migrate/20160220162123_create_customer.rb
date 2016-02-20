class CreateCustomer < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :location_x
      t.integer :location_y
      t.integer :destination_x
      t.integer :destination_y
      t.string :request_type
      t.integer :cab_no
    end
  end
end
