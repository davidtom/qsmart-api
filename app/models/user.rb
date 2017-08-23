# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  email             :string
#  password_digest   :string
#  phone_number      :string
#  profile_image_url :string           default("http://thecampanile.org/wp-content/uploads/2016/10/blank-profile.jpg")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

  has_many :lines_users
  has_many :lines, through: :lines_users
  has_many :created_lines, foreign_key: :owner_id, class_name: "Line"

  validates :email, uniqueness: true
  validates :phone_number, uniqueness: true
  before_validation :format_phone_number
  validates :phone_number, length: { is: 12, message: 'must have 10 digits' }

  def lines_waiting
    self.lines.where('lines_users.waiting = true')
  end

  def phone_number_digits
    self.phone_number.scan(/\d+/).join('').length == 10
  end

  def format_phone_number
    self.phone_number = '+1' + self.phone_number.scan(/\d+/).join('')
  end

end
