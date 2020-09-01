class Absen < ApplicationRecord
  STARTABSEN = '07:00'
  STARTTIME = '07:30'
  LASTSTARTTIME = '10:01'
  MINLASTTIME = '14:00'
  LASTTIME = '15:30'

  belongs_to :employee
  validates :employee_id, uniqueness: { scope: :absen_date, message: "double input" }

  before_validation :set_status_and_over_timer

  validate :start_working_time


  protected
  def set_status_and_over_timer
    # binding.pry
    begin
    # status = 0.5 when time_in 10:01 more or time_out before 14:00
    entry = Time.parse(self.time_in.strftime('%H:%M')) <= Time.parse(STARTTIME) ? Time.parse(STARTTIME) : Time.parse(self.time_in.strftime('%H:%M'))
    out = Time.parse(self.time_out.strftime('%H:%M'))
    # self.status = (entry >= Time.parse(LASTSTARTTIME) || out < Time.parse(MINLASTTIME)) ? 1 : 0.5
    # self.status = ((out - entry) / 3600) >= 8 ? 1 : 0.5

    working_hour = ((out - entry) / 3600)
    if working_hour >= 0 && 2.5 > working_hour
      self.status = 0
    elsif working_hour >= 2.5 && 5 > working_hour
      self.status = 0.5
    elsif working_hour > 5
      self.status = 1
    end

    # over time
    # default
    self.over_time_3 = 0
    self.over_time_2 = 0
    self.over_time_1 = 0

    if self.status.to_i == 1 
      lembur_hour = (((out - entry) / 3600) - 8).to_i
      lembur_min = (((((out - entry) / 3600) - 8) - lembur_hour) * 60 ).to_i

      # over_time_1
      if lembur_hour > 0
        self.over_time_1 = 1
      elsif lembur_hour == 0
        if lembur_min > 30
          self.over_time_1 = 1
        elsif lembur_min > 15 && lembur_min <= 30
          self.over_time_1 = 0.5
        end
      end

      # over_time_2
      lembur_hour = (((out - entry) / 3600) - 9).to_i
      lembur_min = (((((out - entry) / 3600) - 9) - lembur_hour) * 60 ).to_i
      if lembur_hour > 0
        self.over_time_2 = 1
      elsif lembur_hour == 0
        if lembur_min > 30
          self.over_time_2 = 1
        elsif lembur_min > 15 && lembur_min <= 30
          self.over_time_2 = 0.5
        end
      end

      # over_time_3
      lembur_hour = (((out - entry) / 3600) - 10.5).to_i
      lembur_min = (((((out - entry) / 3600) - 10.5) - lembur_hour) * 60 ).to_i
      if lembur_hour > 0
        self.over_time_3 = 1
      elsif lembur_hour == 0
        if lembur_min > 30
          self.over_time_3 = 1
        elsif lembur_min > 15 && lembur_min <= 30
          self.over_time_3 = 0.5
        end
      end
    else
      
    end
  # rescue
    # binding.pry
  end
  end

  def start_working_time
    st = Time.parse(STARTABSEN)
    data = Time.parse(self.time_in.strftime('%H:%M'))
    errors.add(:time_in, :blank, message: "Jam masuk minimal jam 7:30") if st > data 
  end
end

# a = Absen.first
# a.time_out = "18:30"
# a.save

# Masuk 7
# Istitahat 11.30
# Keluar 15.30
# → normal

# Batas Masuk normal 7-10 

# Masuk jam 10.01  keatas
# → ½


# Pulang jam di bawah 14.00 
# → ½

# Pulang jam diatas 16.30
# --> lembur 1 jam

# Pulang jam diatas 17.30
# --> lembur 2 jam

# Lemburan ada 3 column (3 jam)


# Hari tanggal 1 sampai akhir bulan
# Senin - sabtu 
