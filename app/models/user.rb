class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_one :profile, dependent: :destroy

  # Sistema de grupos
  has_many :group_participations
  has_many :groups, through: :group_participations

  # Sistema de Followers/Following
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  after_create :create_user_profile

  # Método para decidir dono do grupo
  def owned_events
    group_participations.ownerships.map(&:group)
  end

  # Métodos para seguir/deixar de seguir
  def follow(other_user)
    following << other_user unless self == other_user || following?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    # Posts do usuário + posts de quem ele segue
    Post.where(user_id: following_ids + [ id ]).order(created_at: :desc)
  end

  private
    def create_user_profile
      self.create_profile
    end
end
