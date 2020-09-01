class CreateSlips < ActiveRecord::Migration[5.2]
  def change
    create_table :slips do |t|
      t.integer :employee_id
      t.integer :month, limit: 2
      t.integer :year, limit: 4
      t.integer :day_count  #
      t.integer :workdays_count
      t.float   :over_time_1_count, limit:4, default: 0.0
      t.float   :over_time_2_count, limit:4, default: 0.0
      t.float   :over_time_3_count, limit:4, default: 0.0
      t.string  :over_time_salary_tot, limmt:10, default: 0.0
      t.string  :salary_one_month, limmt:10, default: 0.0
      t.string  :salary_one_month_tot, limmt:10, default: 0.0
      t.string  :salary_tot, limmt:10, default: 0.0
      t.string :file_path

      t.timestamps
    end
  end
end
