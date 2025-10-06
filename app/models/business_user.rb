class BusinessUser < User
  has_one :business,
          class_name: "Business",
          foreign_key: "user_id",
          dependent: :destroy

  accepts_nested_attributes_for :business
end
