class Business < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  has_many :business_addresses, dependent: :destroy
  accepts_nested_attributes_for :business_addresses, allow_destroy: true

  has_many :business_comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :posts, through: :user

  # Sistema de Followers/Following para bares
  has_many :active_business_relationships, class_name: "BusinessRelationship",
                                          foreign_key: "follower_id",
                                          dependent: :destroy,
                                          as: :follower
  has_many :passive_business_relationships, class_name: "BusinessRelationship",
                                           foreign_key: "followed_id",
                                           dependent: :destroy,
                                           as: :followed
  has_many :followers, through: :passive_business_relationships,
                      source: :follower,
                      source_type: "User"
  has_many :following_businesses, through: :active_business_relationships,
                                 source: :followed,
                                 source_type: "Business"

  # Scopes para tipos de negócios
  scope :bars, -> { where(business_type: "bar") }
  scope :by_type, ->(type) { where(business_type: type) }
  scope :search, ->(query) {
    where("company_name LIKE ? OR business_type LIKE ?", "%#{query}%", "%#{query}%") 
  }

  # Validações
  validates :company_name, :cnpj, :business_type, presence: true
  validates :business_type, inclusion: { in: %w[bar restaurant cafe store other] }
  validate :cnpj_valido_simples

  # Métodos para seguir/deixar de seguir bares
  def follow(other_business)
    following_businesses << other_business unless self == other_business || following?(other_business)
  end

  def unfollow(other_business)
    following_businesses.delete(other_business)
  end

  def following?(other_business)
    following_businesses.include?(other_business)
  end

  # Método para usuários seguirem este business
  def followed_by?(user)
    followers.include?(user)
  end

  def bar?
    business_type == 'bar'
  end

  def humanized_business_type
    case business_type
    when 'bar' then 'Bar'
    when 'restaurant' then 'Restaurante'
    when 'cafe' then 'Café'
    when 'store' then 'Loja'
    when 'other' then 'Outro'
    else business_type.humanize
    end
  end

  private

  def cnpj_valido_simples
    return if cnpj.blank?
    numeros = cnpj.gsub(/\D/, "")
    errors.add(:cnpj, "deve ter 14 números") unless numeros.length == 14
  end
end
