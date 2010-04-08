class Comment < ActiveRecord::Base
  belongs_to :site
  attr_protected :site_id

  validates_presence_of :site_id
  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :body

  def site_key=(key)
    self.site = Site.find_by_token(key)
  end
end
