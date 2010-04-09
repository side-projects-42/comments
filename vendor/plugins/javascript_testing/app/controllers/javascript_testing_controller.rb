class JavascriptTestingController < ApplicationController
  layout nil

  def index
    @count = params.has_key?(:count) ? params[:count].to_i : 2
    @site = Site.find_or_create_by_name('Javascript Testing')

    Comment.where(:site_id => @site.id).delete_all
    opts = {:url => url_for(:controller => 'javascript_testing', :action => 'index', :count => params[:count], :only_path => false), :site_key => @site.token}
    names = %w{Terrence Phillip}
    terms = %w{friend buddy guy}
    @count.times do |i|
      @site.comments.create(opts.merge({
        :name => names[i % names.length],
        :body => "I'm not your #{terms[i % terms.length]}, #{terms[(i % terms.length)-1]}!"
      }))
    end
  end
end
