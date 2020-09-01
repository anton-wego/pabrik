class Employee < ApplicationRecord
  validates :nrp, uniqueness: true

  has_many :absens

  def all_absens(month, year)
    absens.where(["MONTH(absen_date) = ? AND YEAR(absen_date) = ?", month, year])
  end
end
