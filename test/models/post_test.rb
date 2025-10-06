require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @post = Post.new(user: @user)
  end

  test "should be valid with a user" do
    assert @post.valid?
  end

  test "should be invalid without user" do
    @post.user = nil
    assert_not @post.valid?
    assert_includes @post.errors[:user], "must exist"
  end

  test "feed_body should return up to 144 chars when no images" do
    @post.body = "a" * 200
    assert_equal 144, @post.feed_body.length
  end
  #
  #  test "feed_body should return up to 50 chars when there is an image" do
  #    @post.body = "a" * 200
  #    attach_image(@post, "test/fixtures/files/sample.jpg", "image/jpeg")
  #    assert_equal 50, @post.feed_body.length
  #  end

  test "feed_body_truncated? returns true when text is longer than truncated version" do
    @post.body = "a" * 200
    assert @post.feed_body_truncated?
  end

  test "feed_body_truncated? returns false when short body" do
    @post.body = "short text"
    refute @post.feed_body_truncated?
  end
  # Later
  #  test "attached files should all be images" do
  #    # Attach valid image files
  #    attach_image(@post, "test/fixtures/files/sample.jpg", "image/jpeg")
  #    attach_image(@post, "test/fixtures/files/sample.png", "image/png")
  #
  #    @post.images.each do |image|
  #      extension = File.extname(image.filename.to_s).downcase
  #      assert_includes [ ".jpg", ".jpeg", ".png", ".gif" ], extension,
  #                       "Attached file #{image.filename} is not a valid image format"
  #    end
  #  end
  #
  #  test "should reject non-image attachments" do
  #    # This simulates adding a non-image file (e.g., .pdf)
  #    file_path = "test/fixtures/files/sample.pdf"
  #    @post.images.attach(io: File.open(file_path), filename: "sample.pdf", content_type: "application/pdf")
  #
  #    invalid_files = @post.images.reject do |image|
  #      [ ".jpg", ".jpeg", ".png", ".gif" ].include?(File.extname(image.filename.to_s).downcase)
  #    end
  #
  #    assert_not invalid_files.empty?, "Non-image attachments should be detected"
  #  end

  private

  def attach_image(post, path, content_type)
    post.images.attach(io: File.open(path), filename: File.basename(path), content_type: content_type)
  end
end
