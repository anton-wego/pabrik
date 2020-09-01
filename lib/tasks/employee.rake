namespace :employee do
  desc "insert data karyawan"
  task :upload, [:file_path] => :environment do |task, args|
    path = '/Users/youduan/Desktop/pabrik/data-karyawan.csv'

    all_data = []
    CSV.foreach(path, headers: true) do |row|
      new_data = {
        nrp: row['Nrp'].to_s.strip,
        nmk: row['Nmk'].to_s.strip,
        dep: row['Dept'].to_s.strip,
        sub_dep: row['SubDept'].to_s.strip,
        line: row['Line'],
        sex: row['Sex'],
        tmpt_lahir: row['TmpLhr'].to_s.strip,
        lvl: row['Lvl'],
        jabatan: row['jabatan'].to_s.strip,
        status: row['Status'],
        pendidikan: row['Pendidikan'].to_s.strip,
        jurusan: row['Jurusan'].to_s.strip,
        gol_darah: row['Gdarah'].to_s.strip,
        address_1: row['Adr1'].to_s.strip,
        address_2: row['Adr2'].to_s.strip,
        agama: row['Agama'].to_s.strip,
        marital_status: row['Marital_Stat'].to_s.strip,
        cat_1: row['cat1'].to_s.strip,
        cat_2: row['cat2'].to_s.strip,
        conper_1: row['conper1'].to_s.strip,
        conper_2: row['conper2'].to_s.strip,
        cuti: row['cuti'].to_s.strip,
        hak_cuti: row['hakcuti'].to_s.strip
      }

      unless row['TglLhr'].blank?
        new_data[:tgl_lahir] =  Date.strptime(row['TglLhr'], "%m/%d/%Y")
      end
      unless row['TGLMSK'].blank?
        new_data[:tgl_masuk] =  Date.strptime(row['TGLMSK'], "%m/%d/%Y")
      end
      # byebug
      all_data << new_data
    end
    # byebug
    Employee.create all_data unless all_data.blank?
  end
end
