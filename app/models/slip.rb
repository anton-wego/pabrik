class Slip < ApplicationRecord
  belongs_to :employee

  validates :employee_id, presence: true
  before_validation :calculation_over_time_and_workday_count
  before_validation :calculation_salary

  VALID_DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  SALARY = '4000000'

  def slip_filename
    self.year.to_s + '-' + self.month.to_s + '-' + self.employee.nrp
  end

  protected
  def absens
    @absens ||= self.employee.all_absens(self.month, self.year)
  end 
  
  def calculation_over_time_and_workday_count
    first_date = Date.parse("01-#{self.month}-#{self.year}")
    last_date = first_date.end_of_month
    valid_date = []
    valid_absens = []
    (first_date..last_date).to_a.each do |x|
      if VALID_DAYS.include?(x.strftime("%A"))
        valid_date << x 
        valid_absen = absens.find{|y| y.absen_date == x}
        valid_absens << valid_absen unless valid_absen.blank?
      end
    end

    self.day_count = valid_date.size
    self.workdays_count = valid_absens.sum(&:status)

    #over_time
    unless valid_absens.blank?
      self.over_time_1_count = valid_absens.sum(&:over_time_1)
      self.over_time_2_count = valid_absens.sum(&:over_time_2)
      self.over_time_3_count = valid_absens.sum(&:over_time_3)
    end

    # set file name
    self.file_path = "#{self.year}-#{self.month}-#{self.employee.nrp}.csv"
  end

  def calculation_salary
    self.salary_one_month = SALARY
    overt_time_1_salary = (1.5/173) * self.salary_one_month.to_f * self.over_time_1_count.to_f
    overt_time_2_salary = (2.0/173) * self.salary_one_month.to_f * self.over_time_2_count.to_f
    overt_time_3_salary = (2.0/173) * self.salary_one_month.to_f * self.over_time_3_count.to_f

    self.over_time_salary_tot = (overt_time_1_salary + overt_time_2_salary + overt_time_3_salary).to_i

    self.salary_one_month_tot = ((self.workdays_count.to_f / self.day_count.to_f) * self.salary_one_month.to_f).to_i
    self.salary_tot = self.salary_one_month_tot.to_i + self.over_time_salary_tot.to_i
  end
end
