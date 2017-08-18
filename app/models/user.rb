# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  email             :string
#  password_digest   :string
#  phone_number      :integer
#  profile_image_url :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  
  has_many :lines_users
  has_many :lines, through: :lines_users
  has_many :created_lines, foreign_key: :owner_id, class_name: "Line"

end
