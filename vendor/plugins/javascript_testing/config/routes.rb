Rails.application.routes.draw do |map|
  if Rails.env != 'production'
    get "javascript_testing/index" => "javascript_testing#index"
  end
end
