# == Schema Information
#
# Table name: lines_users
#
#  id         :integer          not null, primary key
#  line_id    :integer
#  user_id    :integer
#  waiting    :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LinesUser < ApplicationRecord
  belongs_to :user
  belongs_to :line

  validates :line_id, :user_id, presence: true

  before_validation(on: :create) do
    if self.class.where(line_id: line_id, user_id: user_id, waiting: true)[0]
      errors.add(:waiting, "A user can only have one waiting position in a line")
    end
    if !Line.find(line_id).active
      errors.add(:deactivated, "Line is not active at this time")
    end
  end

end
