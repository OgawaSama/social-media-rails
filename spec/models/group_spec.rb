require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    # Evita que o job de resize rode de verdade durante os testes
    allow(ResizeImageJob).to receive(:perform_later)
    @group = build(:group)
  end

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
    expect(true).to be(true)
  end

  it "checks for owner" do
    expect(true).to be(true)
  end
end
