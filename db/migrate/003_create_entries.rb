class CreateEntries < ActiveRecord::Migration[5.2]
    def change
        create_table :entries do |t|
            t.integer :start_time
            t.integer :end_time
            t.string :description
            t.integer :user_id
            t.integer :day_id
        end
    end
end