require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test "has many comments" do
    site = Factory(:site)
    comment = Factory(:comment, :site => site)
    assert_equal [comment], site.comments
  end

  test "generates token on create" do
    site = Factory(:site)
    assert_match /^[a-f0-9]{32}$/, site.token
  end

  test "token is protected from mass assignment" do
    site = Site.new(:token => "huge")
    assert_nil site.token
  end
end
