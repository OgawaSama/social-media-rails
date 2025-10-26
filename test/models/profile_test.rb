require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @profile = profiles(:one)
  end

  test "should be invalid without a user" do
    @profile.user = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:user], "must exist"
  end

  # TODO: idk how to make the assert_equal work here
  # test "should accept a bio" do
  #   @profile.bio = "i'm bananas"
  #   @profile.reload
  #   assert_equal "i'm bananas", @profile.bio.to_s
  # end

  test "should accept an avatar" do
    attach_avatar(@profile, "test/fixtures/files/image/image.png", "image/png")
    assert_not_nil(@profile.avatar)
  end

  test "should accept a header" do
    attach_header(@profile, "test/fixtures/files/image/image.png", "image/png")
    assert_not_nil(@profile.header)
  end

  private

  def attach_avatar(profile, path, content_type)
    profile.avatar.attach(io: File.open(path), filename: File.basename(path), content_type: content_type)
    @profile.reload
  end

  def attach_header(profile, path, content_type)
    profile.header.attach(io: File.open(path), filename: File.basename(path), content_type: content_type)
    @profile.reload
  end
end
