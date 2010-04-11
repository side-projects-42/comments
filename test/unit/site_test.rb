require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  setup do
    FakeWeb.register_uri(:post, "http://rest.akismet.com/1.1/verify-key", :body => "valid")
  end

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

  test "requires name" do
    site = Factory.build(:site, :name => nil)
    assert !site.valid?
  end

  test "requires unique name" do
    Factory(:site, :name => 'foo')
    site = Factory.build(:site, :name => 'foo')
    assert !site.valid?
  end

  test "requires url" do
    site = Factory.build(:site, :url => nil)
    assert !site.valid?
  end

  test "requires unique url" do
    Factory(:site, :url => 'http://foo.com')
    site = Factory.build(:site, :url => 'http://foo.com')
    assert !site.valid?
  end

  test "requires valid url" do
    site = Factory.build(:site, :url => 'bogus url')
    assert !site.valid?
  end

  test "requires valid akismet key" do
    FakeWeb.register_uri(:post, "http://rest.akismet.com/1.1/verify-key", :body => "invalid")
    site = Factory.build(:site, :akismet_key => 'abcdefg123')
    assert !site.valid?
  end
end
