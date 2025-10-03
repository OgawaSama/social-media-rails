json.extract! profile, :id, :bio, :header, :avatar, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
json.bio profile.bio.to_s
json.header url_for(profile.header)
json.avatar url_for(profile.avatar)
