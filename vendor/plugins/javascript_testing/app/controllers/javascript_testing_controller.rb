class JavascriptTestingController < ApplicationController
  layout nil

  def index
    @site = Site.find_by_name('Javascript Testing')

    Comment.where(:site_id => @site.id).delete_all
    opts = {:url => url_for(:controller => 'javascript_testing', :action => 'index', :only_path => false), :site_key => @site.token}
    @comment_1 = @site.comments.create(opts.merge(:name => "Guy", :body => "You're not my friend, buddy!"))
    @comment_2 = @site.comments.create(opts.merge(:name => "Gal", :body => "You're not by buddy, pal!"))
  end
end
