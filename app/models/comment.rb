class Comment < ActiveRecord::Base
  belongs_to :site
  attr_protected :site_id, :spam
  before_save :check_for_spam

  validates :site_id, :name, :url, :body, :presence => true

  def site_key=(key)
    self.site = Site.find_by_token(key)
  end

  private
    def check_for_spam
      #site = record.site
      #if site && site.url && site.akismet_key
        #Net::HTTP.start("#{site.akismet_key}.rest.akismet.com") do |http|
          #request = Net::HTTP::Post.new('/1.1/comment-check')
          #request.set_form_data(:blog => site.url)
          #result = http.request(request)
          #if result.body != 'false'
            #record.errors[attribute] << "is not valid"
          #end
        #end
      #end
    end
end
