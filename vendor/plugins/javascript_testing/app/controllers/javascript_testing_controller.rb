class JavascriptTestingController < ApplicationController
  layout nil

  def index
    this_url = url_for(:controller => 'javascript_testing', :action => 'index', :count => params[:count], :only_path => false)

    @count = params.has_key?(:count) ? params[:count].to_i : 2
    @site = Site.find_by_name('Javascript Testing')
    if @site.nil?
      @site = Site.create(:name => 'Javascript Testing', :url => this_url)
    end

    Comment.where(:site_id => @site.id).delete_all
    opts = {:page_url => this_url, :site_key => @site.token}
    names = %w{Terrence Phillip}
    terms = %w{friend buddy guy}
    @count.times do |i|
      @site.comments.create!(opts.merge({
        :name => names[i % names.length], :ip => '10.1.2.3', :agent => 'Leet Browser',
        :body => "I'm not your #{terms[i % terms.length]}, #{terms[(i % terms.length)-1]}!"
      }))
    end
  end
end
