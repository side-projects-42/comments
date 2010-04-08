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

  test "requires url" do
    comment = Factory.build(:comment, :url => nil)
    assert !comment.valid?
  end

  test "requires body" do
    comment = Factory.build(:comment, :body => nil)
    assert !comment.valid?
  end
end
