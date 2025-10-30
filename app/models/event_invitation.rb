class EventInvitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, polymorphic: true
end
