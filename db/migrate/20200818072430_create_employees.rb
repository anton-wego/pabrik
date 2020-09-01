class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :nrp,              null: false, default: "", limit: 15
      t.string :nmk,              null: false, default: "", limit: 35
      t.string :dep,              null: false, default: "", limit: 5
      t.string :sub_dep,          null: false, default: "", limit: 5
      t.string :line,             limit: 5
      t.string :sex,              null: false, default: "", limit: 1
      t.string :tmpt_lahir,              null: false, default: "", limit: 15
      t.date   :tgl_lahir
      t.date   :tgl_masuk
      t.integer :lvl, limit: 2
      t.string :jabatan, limit: 20
      t.integer :status, limit: 2
      t.string :pendidikan, limit: 5
      t.string :jurusan, limit: 30
      t.string :gol_darah, limit: 3
      t.string :address_1
      t.string :address_2
      t.string :agama,   limit: 10
      t.string :marital_status, limit: 10
      t.string :cat_1, limit: 10
      t.string :cat_2, limit: 10
      t.string :conper_1, limit: 10
      t.string :conper_2, limit: 10
      t.integer :cuti, default: 0
      t.integer :hak_cuti, default: 0


      t.timestamps
    end
  end
end
