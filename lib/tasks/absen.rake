namespace :absen do
  desc "insert data karyawan"
  task :upload, [:file_path, :sheet_name] => :environment do |task, args|

    @not_found_data = []
    def save_data(new_data, headers)
      # ignore when time_in is blank
      return if new_data[headers.index('Jam Masuk')].blank?

      emp = Employee.find_by_nrp(new_data[0])
      if emp.nil?
        @not_found_data  << new_data[0]
        puts "nrp: #{new_data[0]} not found"
      else
        a = Absen.where(employee_id: emp.id, absen_date: new_data[headers.index('Tanggal')]).first
        a = Absen.new if a.blank?

        a.employee_id = emp.id
        headers.each_with_index do |x, i|
          next if x.blank?
          a.absen_date = new_data[i] if x == 'Tanggal'
          a.time_in = new_data[i] if x == 'Jam Masuk'
          a.break_out = new_data[i] if x == 'Istirahat Keluar'
          a.break_in = new_data[i] if x == 'Istirahat Masuk'
          a.time_out = new_data[i] if x == 'Jam Pulang'
          # a.over_time_1 = new_data[i] if x == 'Stk.Lmb1'
          # a.over_time_2 = new_data[i] if x == 'Stk.Lmb2'
          # a.over_time_3 = new_data[i] if x == 'Stk.Lmb3'
        end
        a.save  
      end
    end

    path = '/Users/youduan/Desktop/pabrik/LINE-MAR-20.xlsx'
    path = '/Users/youduan/Desktop/pabrik/data-absensi.xlsx'
    

    xlsx = Roo::Excelx.new(path)
    # xlsx.default_sheet = '1'
    max_row = xlsx.last_row
    max_col = xlsx.last_column
    headers = []
    all_data = []


    1.upto(max_row).each do |num_row|
      next if xlsx.cell(num_row, 1).blank? && xlsx.cell(num_row, 2).blank? 
      headers = [] if xlsx.cell(num_row, 1).blank? && !xlsx.cell(num_row, 2).blank?

      new_data = [] 
      1.upto(max_col).each do |num_col|
        headers << xlsx.cell(num_row, num_col).to_s.strip if xlsx.cell(num_row, 1).blank?
        
        new_data << xlsx.cell(num_row, num_col).to_s.strip
      end

      unless new_data == headers
        all_data << new_data 
        save_data(new_data, headers)
      end
      # binding.pry
    end

    binding.pry
  end
end
