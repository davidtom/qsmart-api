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

class LinesUsers < ApplicationRecord
end
