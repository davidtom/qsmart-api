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
  validate :user_waiting_once_in_line

  def user_waiting_once_in_line
    # ensure that a user is actively waiting in a line only once
    if !self.class.where(line_id: line_id, user_id: user_id, waiting: true).empty?
      errors.add(:waiting, "A user can only have one waiting position in a line")
    end
  end

end
