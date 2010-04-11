class Site < ActiveRecord::Base
  has_many :comments
  attr_protected :token
  before_create :generate_token

  class UrlValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        uri = URI.parse(value)
      rescue URI::InvalidURIError
        record.errors[attribute] << "must be a valid URI"
      end
    end
  end

  class AkismetKeyValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if record.url && record.akismet_key
        Net::HTTP.start("rest.akismet.com") do |http|
          request = Net::HTTP::Post.new('/1.1/verify-key')
          request.set_form_data(:key => record.akismet_key, :blog => record.url)
          result = http.request(request)
          if result.body != 'valid'
            record.errors[attribute] << "is not valid"
          end
        end
      end
    end
  end

  with_options(:presence => true, :uniqueness => true) do |opts|
    opts.validates :name
    opts.validates :url, :url => true
  end
  validates :akismet_key, :akismet_key => true

  private
    def generate_token
      now = Time.now
      self.token = Digest::MD5.hexdigest(Digest::MD5.hexdigest("#{now.to_s}-#{now.usec}") + "omgcomments")
    end
end
