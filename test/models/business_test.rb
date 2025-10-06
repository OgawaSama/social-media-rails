require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) # assumes you have a users(:one) fixture
    @business = Business.new(
      company_name: "Placeholder Project",
      cnpj: "49610796001",
      user: @user
    )
  end
#
#  test "should be valid with valid attributes" do
#    assert @business.valid?
#  end

  test "should be invalid without company_name" do
    @business.company_name = nil
    assert_not @business.valid?
    assert_includes @business.errors[:company_name], "can't be blank"
  end

  test "should be invalid without cnpj" do
    @business.cnpj = nil
    assert_not @business.valid?
    assert_includes @business.errors[:cnpj], "can't be blank"
  end

  test "should be invalid if cnpj has less than 14 digits" do
    @business.cnpj = "1234567890"
    assert_not @business.valid?
    assert_includes @business.errors[:cnpj], "deve ter 14 números"
  end

  test "should be invalid if cnpj has more than 14 digits" do
    @business.cnpj = "99999999999999999999999999"
    assert_not @business.valid?
    assert_includes @business.errors[:cnpj], "deve ter 14 números"
  end
#
#  test "should allow nested business addresses" do
#    @business.business_addresses.build(address: "Rua do abububle, 321")
#    assert_difference "BusinessAddress.count", 1 do
#      @business.save!
#    end
#  end
#
#  test "should destroy associated business_addresses on destroy" do
#    @business.save!
#    @business.business_addresses.create!(address: "Avenida Ceci, 945")
#    assert_difference "BusinessAddress.count", -1 do
#      @business.destroy
#    end
#  end
end
