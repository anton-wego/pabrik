ActiveAdmin.register Slip do
  menu label: 'Slip Salary karywan', parent: 'Karyawan'

  config.per_page = 50
  config.paginate = true

  filter :employee_id, as: :select, collection: Employee.select('id, nrp, nmk').map{ |x| ["#{x.nrp}-#{x.nmk}", x.id] }
  filter :month, label: 'Bulan', as: :select, collection: (1..12).to_a
  filter :year, label: 'Tahun', as: :select, collection: (2020..2030).to_a
  preserve_default_filters!
  remove_filter :employee, :created_at, :updated_at, :file_path



  controller do 
    def get_absensi
      # @absens = Absen.where(:employee_id => params[:employee_id]).where(["MONTH(absen_date) = ? AND YEAR(absen_date) = ?", params[:month], params[:year]])
      @absens = Absen.where(employee_id: 670).where(["MONTH(absen_date) = ? AND YEAR(absen_date) = ?", params[:month], params[:year]])
      render json: { html: render_to_string(partial: 'admin/slips/absen_tbl', locals: { absens: @absens })}
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :employee_id, :month, :year, :day_count, :workdays_count, :file_path
  #
  # or
  #
  # permit_params do
  #   permitted = [:employee_id, :month, :year, :day_count, :workdays_count, :file_path]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.semantic_errors *f.object.errors.keys

    f_obj = f.object

    f_obj.month ||= Date.today.month
    f_obj.year ||= Date.today.year
    f.inputs do
      f.input :employee_id, as: :select, collection: Employee.select('id, nrp, nmk').map{ |x| ["#{x.nrp}-#{x.nmk}", x.id] }, input_html: { class: 'js-show-absen-ajax', disabled: !f_obj.new_record? }
      f.input :month, as: :select, collection: (1..12).to_a, include_blank: false, include_hidden: false, input_html: {class: 'js-show-absen-ajax', disabled: !f_obj.new_record? }
      f.input :year, as: :select, collection: (2020..2030).to_a, include_blank: false, include_hidden: false, input_html: {class: 'js-show-absen-ajax', disabled: !f_obj.new_record? }
    end
    f.inputs id: 'absen_list' do 
      render partial: 'absen_tbl', locals: { absens: []}
    end
    
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  index :pagination_total => false do
    column :id
    column 'Nrp - Nmk' do |x|
      "#{x.employee.nrp} - #{x.employee.nmk}" rescue '-'
    end

    column :month
    column :year
    column :file_path

    actions
  end


  show do |a|
    attributes_table do
      row 'Nrp - Nmk' do |x| "#{x.employee.nrp} - #{x.employee.nmk}" end
      row :month
      row :year
      row :day_count
      row :workdays_count
      row "jumlah over time 1" do |x| x.over_time_1_count end
      row "jumlah over time 2" do |x| x.over_time_2_count end
      row "jumlah over time 3" do |x| x.over_time_3_count end
      row "salary over time (total)" do |x| x.over_time_salary_tot end
      row "total salary" do |x| x.salary_tot end
    end
  end
end
