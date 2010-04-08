class Site < ActiveRecord::Base
  has_many :comments
  attr_protected :token
  before_create :generate_token

  private
    def generate_token
      now = Time.now
      self.token = Digest::MD5.hexdigest(Digest::MD5.hexdigest("#{now.to_s}-#{now.usec}") + "omgcomments")
    end
end
