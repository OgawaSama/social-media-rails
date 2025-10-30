FactoryBot.define do
  factory :event_invitation do
    event { nil }
    invitee { nil }
    status { 1 }
  end
end
