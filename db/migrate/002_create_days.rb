class CreateDays < ActiveRecord::Migration[5.2]
    def change
        create_table :days do |t|
            t.integer :month
            t.integer :day
        end
    end
end