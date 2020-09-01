namespace :slip do
  desc "create slip file"
  task :create, [:year, :month, :employee_id] => :environment do |task, args|

    record = Slip.where(year: args.year, month: args.month, employee_id: args.employee_id).first
    if record.blank?
      puts "Record not found"
      return
    end

    periode = Date.parse("1-#{record.month}-#{record.year}").strftime("%d %B %Y") + ' s/d ' + Date.parse("1-#{record.month}-#{record.year}").end_of_month.strftime("%d %B %Y")
    employee = record.employee

    filename = record.slip_filename+".csv" 
    CSV.open(filename, "wb") do |csv|
      csv << []
      csv << []
      csv << ['', '', 'SLIP GAJI', '']
      csv << ['', '', 'PERIODE', '', ':', '', periode ]
      csv << ['', '', 'PT. RABBONI INDONESIA GARMENT']
      csv << ['', '', 'NIK', '', ':', '', employee.nrp]
      csv << ['', '', 'Nama', '', ':', '', employee.nmk]
      csv << ['', '', 'Departement', '', ':', '', employee.dep]
      csv << ['', '', 'Sub Dep', '', ':', '', employee.sub_dep, ''] 
      csv << ['', '', 'Line', '', ':', '', employee.line]
      csv << ['', '', 'Jabatan', '', ':', '', employee.jabatan]
      csv << []
      csv << []
      csv << ['', '', '', '', '', 'Hari Kerja', record.day_count]
      csv << []
      csv << ['', '', 'Pokok', '', '', 'Rp','', record.salary_one_month]
      csv << []
      
      csv << ['', '', 'Total Upah', '', '', 'Rp','', record.salary_one_month_tot]
      csv << ['', '', 'Lembur', '', '', 'Rp','', record.over_time_salary_tot]
      csv << []
      csv << []
      csv << []
      csv << []
      csv << ['', '', 'Total', '', '', 'Rp','', record.salary_tot]
    end
  end
end
