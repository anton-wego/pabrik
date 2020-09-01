ActiveAdmin.register Employee do
  menu label: 'Data karyawan', parent: 'Karyawan'

  filter :nrp, label: 'Nrp'
  filter :nmk, label: 'Nama'
  filter :dep
  filter :sub_dep
  filter :line
  filter :jabatan
  filter :tgl_masuk


  index do
    column :id
    column :nrp
    column :nmk, label: 'Name'
    column :dep
    column :sub_dep
    column :line
    column :jabatan

    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :nrp, :nmk, :dep, :sub_dep, :line, :sex, :tmpt_lahir, :tgl_lahir, :tgl_masuk, :lvl, :jabatan, :status, :pendidikan, :jurusan, :gol_darah, :address_1, :address_2, :agama, :marital_status, :cat_1, :cat_2, :conper_1, :conper_2, :cuti, :hak_cuti
  #
  # or
  #
  # permit_params do
  #   permitted = [:nrp, :nmk, :dep, :sub_dep, :line, :sex, :tmpt_lahir, :tgl_lahir, :tgl_masuk, :lvl, :jabatan, :status, :pendidikan, :jurusan, :gol_darah, :address_1, :address_2, :agama, :marital_status, :cat_1, :cat_2, :conper_1, :conper_2, :cuti, :hak_cuti]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :nrp
      f.input :nmk
      f.input :dep
      f.input :sub_dep
      f.input :line
      f.input :sex
      f.input :tmpt_lahir
      f.input :tgl_lahir, as: :datepicker, datepicker_options: {
                        min_date: "1900-01-01",
                        max_date: Date.today()
                      }
      f.input :tgl_masuk, as: :datepicker
      f.input :lvl
      f.input :jabatan
      f.input :status
      f.input :pendidikan
      f.input :jurusan
      f.input :gol_darah, as: :select, collection: ['A', 'B', 'AB', 'O']
      f.input :address_1, as: :text
      f.input :address_2, as: :text
      f.input :agama
      f.input :marital_status
      f.input :cat_1
      f.input :cat_2
      f.input :conper_1
      f.input :conper_2
      f.input :cuti
      f.input :hak_cuti




    end
    
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  
end
