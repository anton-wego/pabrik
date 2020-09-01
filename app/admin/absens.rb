ActiveAdmin.register Absen do
  menu label: 'Absensi karyawan', parent: 'Karyawan'

  config.per_page = 50
  config.paginate = true

  filter :employee_id, as: :select, collection: Employee.select('id, nrp, nmk').map{ |x| ["#{x.nrp}-#{x.nmk}", x.id] }
  preserve_default_filters!
  remove_filter :employee, :created_at, :updated_at

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :employee_id, :absen_date, :time_in, :break_in, :break_out, :time_out, :status, :over_time_1, :over_time_2, :over_time_3
  #
  # or
  #
  # permit_params do
  #   permitted = [:employee_id, :absen_date, :time_in, :break_in, :break_out, :time_out, :status, :over_time_1, :over_time_2, :over_time_3]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :employee_id, as: :select, collection: Employee.select('id, nrp, nmk').map{ |x| ["#{x.nrp}-#{x.nmk}", x.id] }
      f.input :absen_date
      f.input :time_in
      f.input :break_out
      f.input :break_in
      f.input :time_out
    end
    
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  index :pagination_total => false do
    column :id
    column 'Nrp - Nmk' do |x|
      "#{x.employee.nrp} - #{x.employee.nmk}"
    end

    column :absen_date
    column 'jam masuk' do |y|
      y.time_in.strftime("%H:%M") rescue '-'
    end
    column 'jam keluar' do |y|
      y.time_out.strftime("%H:%M") rescue '-'
    end

    actions
  end

  show do |a|
    attributes_table do
      row 'Nrp - Nmk' do |x| "#{x.employee.nrp} - #{x.employee.nmk}" end
      row :absen_date
      row 'jam masuk' do |y|
        y.time_in.strftime("%H:%M") rescue '-'
      end

      row 'istirahat keluar' do |y|
        y.break_out.strftime("%H:%M") rescue '-'
      end

      row 'istirahat masuk' do |y|
        y.break_in.strftime("%H:%M") rescue '-'
      end

      row 'jam keluar' do |y|
        y.time_out.strftime("%H:%M") rescue '-'
      end

      row :status
      row :over_time_1
      row :over_time_2
      row :over_time_3
    end
  end
end
