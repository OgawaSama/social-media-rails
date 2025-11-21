require 'rails_helper'

RSpec.describe BusinessAddress, type: :model do
  let(:business) { create(:business) }
  let(:business_address) { build(:business_address, business: business) }

  it 'checks business ownership' do
    expect(business_address.business).to eq(business)

    business_address.business = nil
    expect(business_address).not_to be_valid
  end

  it 'validates street' do
    business_address.street = nil
    expect(business_address).not_to be_valid
  end

  it 'validates city' do
    business_address.city = nil
    expect(business_address).not_to be_valid
  end

  it 'validates state' do
    business_address.state = nil
    expect(business_address).not_to be_valid
  end

  it 'validates zip' do
    business_address.zip = nil
    expect(business_address).not_to be_valid
  end

  it 'checks for cardapio presence' do
    expect(business_address).to have_one(:cardapio)
  end
end
