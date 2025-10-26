require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @group = build(:group)
  end

  # [Bookmark]
  # edit image validations after changing file restrictions
  it "checks for valid header formats" do
    expect(@group.header).to be_valid

    @group.header.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'pdf.pdf')),
            filename: 'pdf.pdf',
            content_type: 'application/pdf'
        )
    expect(@group).not_to be_valid
  end

  it "checks for valid avatar formats" do
    expect(@group.avatar).to be_valid

    @group.avatar.attach(
            io: File.open(Rails.root.join('test', 'fixtures', 'files', 'pdf.pdf')),
            filename: 'pdf.pdf',
            content_type: 'application/pdf'
        )
    expect(@group).not_to be_valid
  end

  it "checks for valid bio" do
    # [Bookmark]
    # no restrictions for now
    expect(true).to be(true)
  end

  it "checks for owner" do
    # [Bookmark]
    # for now, nothing
    # change when implement ownership on groups
    expect(true).to be(true)
  end
end
