source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'sprockets-rails'
gem 'pg', '~> 1.1'
gem 'administrate'
gem 'devise'
gem 'carrierwave'
gem 'puma', '~> 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'jbuilder'
gem 'redis', '~> 4.0'
gem 'simple_form', git: 'https://github.com/loqimean/simple_form.git', branch: 'main'
gem 'bcrypt', '~> 3.1.7'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'meta-tags'
gem 'avatarro'
gem 'bootsnap', require: false
gem 'tinymce-rails', '~> 5.10'
gem 'view_component'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'cocoon'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy'
gem 'image_processing', '~> 1.2'
gem 'mini_magick'
gem 'searchkick'
gem  'elasticsearch', "< 7.14"

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
end

group :development do
  gem 'any_login'
  gem 'annotate'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov'
  gem 'rspec-sidekiq'
end
