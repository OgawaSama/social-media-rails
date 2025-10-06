class Business < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  has_many :business_addresses, dependent: :destroy
  accepts_nested_attributes_for :business_addresses, allow_destroy: true

  validates :company_name, :cnpj, presence: true
  validate :cnpj_valido_simples

  private

  def cnpj_valido_simples
    return if cnpj.blank?
    numeros = cnpj.gsub(/\D/, "")
    errors.add(:cnpj, "deve ter 14 números") unless numeros.length == 14
  end
end
