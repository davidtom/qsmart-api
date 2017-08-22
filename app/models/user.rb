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

  def lines_waiting
    self.lines.where('lines_users.waiting = true')
  end

end
