Factory.define :site do |s|
  s.sequence(:name) { |n| "Site #{n}" }
  s.sequence(:url) { |n| "http://example.org/blog-#{n}" }
end

Factory.define :comment do |c|
  c.name { Forgery(:name).full_name }
  c.body { Forgery(:lorem_ipsum).sentence }
  c.page_url "http://example.org"
  c.ip '10.1.2.3'
  c.agent 'Leet Browser'
  c.association :site
end
