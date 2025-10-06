require "test_helper"

class BusinessAddressTest < ActiveSupport::TestCase
  def setup
    @business = businesses(:one) # assumes you have a fixture
    @address = BusinessAddress.new(
      business: @business,
      street: "Av. Paulista, 1000",
      city: "São Paulo",
      state: "SP",
      zip: "01310-100"
    )
  end

  test "should be valid with attributes" do
    assert @address.valid?
  end

  test "should be invalid without street" do
    @address.street = nil
    assert_not @address.valid?
    assert_includes @address.errors[:street], "can't be blank"
  end

  test "should be invalid without city" do
    @address.city = nil
    assert_not @address.valid?
    assert_includes @address.errors[:city], "can't be blank"
  end

  test "should be invalid without state" do
    @address.state = nil
    assert_not @address.valid?
    assert_includes @address.errors[:state], "can't be blank"
  end

  test "should be invalid without zip" do
    @address.zip = nil
    assert_not @address.valid?
    assert_includes @address.errors[:zip], "can't be blank"
  end

  test "should belong to a business" do
    @address.business = nil
    assert_not @address.valid?
    assert_includes @address.errors[:business], "must exist"
  end
end
