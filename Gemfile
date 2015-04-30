source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'sass-rails'
gem 'haml-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'bcrypt'
gem 'bootstrap_form'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'
  gem 'pry'
  gem 'rspec-rails'
  gem 'mysql2'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
