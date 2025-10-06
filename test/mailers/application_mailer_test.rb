require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "default from é configurado corretamente" do
    assert_equal ["from@example.com"], ApplicationMailer.default[:from]
  end

  test "layout do mailer é o esperado" do
    assert_equal "mailer", ApplicationMailer._layout
  end
end
