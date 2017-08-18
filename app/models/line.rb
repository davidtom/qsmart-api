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
end
