require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = Factory(:comment)
  end

  test "should get index" do
    site = Factory(:site)
    comment_1 = Factory(:comment, :site => site, :page_url => "http://example.org/foo")
    comment_2 = Factory(:comment, :site => site, :page_url => "http://example.org/bar")
    comment_3 = Factory(:comment, :page_url => "http://example.org/foo")

    get :index, :format => :json, :site_key => site.token, :page_url => "http://example.org/foo"
    assert_response :success
    assert_equal [comment_1], assigns(:comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment" do
    site = Factory(:site)
    @request.remote_addr = '10.1.2.3'
    @request.user_agent = 'Leet Browser'
    @request.env['HTTP_REFERER'] = 'http://example.org'
    assert_difference('Comment.count') do
      post :create, {
        :format => 'json',
        :comment => Factory.attributes_for(:comment, :site_key => site.token)
      }
    end
    assert_response :success

    comment = assigns(:comment)
    assert_equal site, comment.site
    assert_equal '10.1.2.3', comment.ip
    assert_equal 'Leet Browser', comment.agent
    assert_equal 'http://example.org', comment.referrer
  end

  test "failed comment creation" do
    assert_no_difference('Comment.count') do
      post :create, {
        :format => 'json',
        :comment => Factory.attributes_for(:comment, :name => nil)
      }
    end
    assert_response 422
  end

  test "should show comment" do
    get :show, :id => @comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @comment.to_param
    assert_response :success
  end

  test "should update comment" do
    put :update, :id => @comment.to_param, :comment => @comment.attributes
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param
    end

    assert_redirected_to comments_path
  end

  test "embed content type" do
    get :embed
    assert_equal "text/javascript", @response.content_type
  end
end
