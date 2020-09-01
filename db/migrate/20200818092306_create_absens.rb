class CreateAbsens < ActiveRecord::Migration[5.2]
  def change
    create_table :absens do |t|
      t.integer :employee_id
      t.date :absen_date
      t.time :time_in
      t.time :break_in
      t.time :break_out
      t.time :time_out
      t.float :status, default: 0
      t.float :over_time_1, default: 0
      t.float :over_time_2, default: 0
      t.float :over_time_3, default: 0

      t.timestamps
    end

    add_index :absens, :employee_id
  end
end
