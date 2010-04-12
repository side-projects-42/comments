class Comment < ActiveRecord::Base
  belongs_to :site
  attr_protected :site_id, :spam
  before_save :check_for_spam

  validates :site_id, :name, :page_url, :body, :ip, :agent, :presence => true

  def site_key=(key)
    self.site = Site.find_by_token(key)
  end

  private
    def check_for_spam
      if site && site.url && site.akismet_key
        Net::HTTP.start("#{site.akismet_key}.rest.akismet.com") do |http|
          request = Net::HTTP::Post.new('/1.1/comment-check')

          data = { 'blog' => site.url, 'user_ip' => ip, 'user_agent' => agent,
            'comment_author' => name, 'comment_content' => body }
          data['referrer'] = referrer               if referrer
          data['comment_author_email'] = email      if email
          data['comment_author_url'] = author_url   if author_url

          request.set_form_data(data)
          result = http.request(request)
          if result.body != 'false'
            self.spam = true
          end
        end
      end
    end
end
