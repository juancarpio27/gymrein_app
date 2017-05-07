source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#Rails
gem 'rails', '~> 5.0.1'
#Databases
gem 'sqlite3', group: :development
gem 'pg' # Added postgres and made it production only.
gem 'rails_12factor'
#Server
gem 'puma', '~> 3.0'
# Stylesheets
gem 'sass-rails', '~> 5.0'
#Compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

#Bootstrap style
gem "twitter-bootstrap-rails"
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'

#Upload pictures
gem "paperclip", "~> 5.0.0"
gem 'aws-sdk', '~> 2.3'

#Authentication and user control
gem 'devise'

#Notifications
gem 'houston'
gem 'pushmeup'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
