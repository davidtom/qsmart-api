# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  code       :string
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

  validates :name, :owner_id, presence: true
  validates :code, uniqueness: true


  def generate_code
    code = Faker::Internet.password(3,3).upcase
    Line.all.pluck(:code).include?(code) ? generate_code : self.code = code
  end

  def waiting_users
    # a = ActiveRecord::Base.connection
    # result = a.execute(%Q{SELECT users.id, users.first_name, users.last_name, users.email, users.phone_number, users.profile_image_url, lines_users.waiting  FROM users JOIN lines_users ON users.id = lines_users.user_id WHERE waiting=true AND lines_users.line_id=#{a.quote(self.id)};})
    # result
    # user_ids = LinesUser.where(line_id: self.id, waiting: true).order(created_at: :asc, updated_at: :asc).pluck(:user_id)

    # user_ids.map{|user_id| }

    self.users.where("lines_users.waiting=true").order("lines_users.created_at ASC")

    # User.where(id: user_ids).joins("JOIN lines_users on lines_users.user_id = users.id").where("lines_users.waiting=true").order("lines_users.created_at asc")


    # User.joins("JOIN lines_users on lines_users.user_id = users.id JOIN lines on lines.id = lines_users.line_id WHERE lines.id = ? AND lines_users.waiting = 'true' ORDER BY lines_users.created_at ASC")

    # Author.joins("INNER JOIN posts ON posts.author_id = authors.id AND posts.published = 't'")
    # NEED TO SORT User.where by Lines_users.created_at
    # line_id = self.id
    # sql = <<-sql
    # SELECT *
    # FROM users
    # JOIN lines_users ON users.id = lines_users.user_id
    # JOIN lines on lines.id = lines_users.line_id
    # WHERE lines.id = ? AND waiting="t"
    # ORDER BY lines_users.created_at ASC
    # sql
    # User.find_by_sql(sql, line_id)

    # sql = <<-sql
    # SELECT users.id, users.first_name, users.last_name, users.email,
    # users.phone_number, users.profile_image_url, lines_users.waiting
    # FROM users
    # JOIN lines_users ON users.id = lines_users.user_id
    # JOIN lines on lines.id = lines_users.line_id
    # WHERE line = ? AND waiting=true;
    # sql
    # Line.find_by_sql(sql, line_id)
  end

  def user_count
    self.waiting_users.count
  end
end
