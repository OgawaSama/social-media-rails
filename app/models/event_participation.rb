class EventParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id }

  after_create :reward_points

  private
  def reward_points
    if event.points_rewarded.present? && event.points_rewarded > 0
      user.increment!(:points, event.points_rewarded)
    end
  end
end
