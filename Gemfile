source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

group :production do
  gem 'pg', '~> 0.18.4'
end

gem 'blacklight', '>= 6.1'
gem 'blacklight-marc', '~> 6.1'
gem 'coffee-rails'
gem 'devise'
gem 'devise-guests', '~> 0.6'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'
gem 'rsolr', '>= 1.0'
gem 'sass-rails', '~> 5.0'
gem 'therubyracer', platforms: :ruby
gem 'traject'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'capistrano', '~> 3.8.0'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '>= 1.1.3'
  gem 'highline'

  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'method_source'
  gem 'pry'
  gem 'pry-doc'
  gem 'selenium-webdriver'
  gem 'solr_wrapper', '>= 0.3'
  gem 'sqlite3'
end
