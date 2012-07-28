source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'nokogiri'
gem 'heroku'


# in production environments by default.
group :assets do
gem 'uglifier', '>= 1.0.3'
gem 'sass-rails'
gem 'railties'
end

group :development, :test do
        gem 'sqlite3'
        gem 'sqlite3-ruby'
# Removed debugger to be able to use ruby 1.9.2 because debugger requires linecache which was not working
#   gem 'ruby-debug'
end

group :production do
        gem 'pg'
        gem 'thin'
end
