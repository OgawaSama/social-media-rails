require "test_helper"

class BusinessUserTest < ActiveSupport::TestCase
  setup do
    @business_user = BusinessUser.create!(
      email: "business@example.com",
      password: "password",
      business_attributes: {
        name: "Loja de Teste",
        category: "Comércio"
      }
    )
  end

  test "should create business together with business_user" do
    assert @business_user.business.present?, "Business não foi criado junto com o BusinessUser"
    assert_equal "Loja de Teste", @business_user.business.name
  end

  test "should destroy associated business when business_user is destroyed" do
    business_id = @business_user.business.id
    @business_user.destroy
    assert_nil Business.find_by(id: business_id), "Business não foi destruído junto com o BusinessUser"
  end

  test "should have correct association metadata" do
    reflection = BusinessUser.reflect_on_association(:business)
    assert_equal :has_one, reflection.macro
    assert_equal "Business", reflection.class_name
    assert_equal "user_id", reflection.foreign_key
    assert_equal :destroy, reflection.options[:dependent]
  end
end
