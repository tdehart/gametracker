# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_and_belongs_to_many :games, uniq: true
  has_many :tournaments, through: :followed_tournaments
  has_many :followed_tournaments, dependent: :destroy

  def following?(object)
    if object.is_a?(Tournament)
      followed_tournaments.find_by_tournament_id(object.id)
    elsif object.is_a?(Game)

    end
  end

  def follow!(object)
    if object.is_a?(Tournament)
      followed_tournaments.create!(tournament_id: object.id)
    elsif object.is_a?(Game)

    end
  end

  def unfollow!(object)
    if object.is_a?(Tournament)
      followed_tournaments.find_by_tournament_id(object.id).destroy
    elsif object.is_a?(Game)

    end
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end


