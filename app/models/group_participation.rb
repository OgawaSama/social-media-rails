class GroupParticipation < ApplicationRecord
  belongs_to :group
  belongs_to :user

  scope :ownerships, -> { where(owner: true) }
end
