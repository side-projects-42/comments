require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "belongs_to site" do
    site = Factory(:site)
    comment = Comment.new { |c| c.site_id = site.id }
    assert_equal site, comment.site
  end

  test "protects site_id from mass assignment" do
    site = Factory(:site)
    comment = Comment.new(:site_id => site.id)
    assert_nil comment.site_id
  end

  test "site_key sets site_id" do
    site = Factory(:site)
    comment = Comment.new(:site_key => site.token)
    assert_equal site.id, comment.site_id
  end

  test "requires site_id" do
    comment = Factory.build(:comment, :site => nil)
    assert !comment.valid?
  end

  test "requires name" do
    comment = Factory.build(:comment, :name => nil)
    assert !comment.valid?
  end

  test "requires page_url" do
    comment = Factory.build(:comment, :page_url => nil)
    assert !comment.valid?
  end

  test "requires body" do
    comment = Factory.build(:comment, :body => nil)
    assert !comment.valid?
  end

  test "requires false akismet spam check" do
    FakeWeb.register_uri(:post, "http://rest.akismet.com/1.1/verify-key", :body => "valid")
    FakeWeb.register_uri(:post, 'http://abcdefg123.rest.akismet.com/1.1/comment-check', :body => 'true')
    site = Factory(:site, :akismet_key => 'abcdefg123')
    comment = Factory(:comment, :site => site)
    assert comment.spam?
  end

  test "requires ip" do
    comment = Factory.build(:comment, :ip => nil)
    assert !comment.valid?
  end

  test "requires agent" do
    comment = Factory.build(:comment, :agent => nil)
    assert !comment.valid?
  end
end
