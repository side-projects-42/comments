Factory.define :site do |s|
  s.sequence(:name) { |n| "Site #{n}" }
  s.sequence(:url) { |n| "http://example.org/blog-#{n}" }
end

Factory.define :comment do |c|
  c.name { Forgery(:name).full_name }
  c.body { Forgery(:lorem_ipsum).sentence }
  c.url "http://example.org"
  c.association :site
end
