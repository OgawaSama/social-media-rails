require 'rails_helper'

RSpec.describe Profile, type: :model do
  before(:each) do
    @user = build(:user)
    @profile = build(:profile, user: @user)
  end

  it "checks for user ownership" do
    expect(@profile.user).to eq(@user)

    @profile.user = nil
    expect(@profile).not_to be_valid
  end

  it "checks for valid avatar formats" do
    expect(@profile.avatar).to be_valid

    @profile.avatar.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'pdf.pdf')),
            filename: 'pdf.pdf',
            content_type: 'application/pdf'
        )
    expect(@profile).not_to be_valid
  end

  it "checks for valid header formats" do
    expect(@profile.header).to be_valid

    @profile.header.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'pdf.pdf')),
            filename: 'pdf.pdf',
            content_type: 'application/pdf'
        )
    expect(@profile).not_to be_valid
  end

  it "checks for valid bio" do
    # [Bookmark]
    # Add when having some restrictions
  end
end
