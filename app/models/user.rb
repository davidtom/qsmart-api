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
end
