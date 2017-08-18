# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  name       :string
#  owner_id   :integer
#  image_url  :string
#  type       :string
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Line < ApplicationRecord
  has_many :lines_users
  has_many :users, through: :lines_users
  belongs_to :owner, class_name: "User"

  before_create :generate_code

  def generate_code
    code = Faker::Internet.password(3,3).upcase
    Line.all.pluck(:code).include?(code) ? generate_code : self.code = code
  end
end
