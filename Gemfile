source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',                   '6.0.3.1'
gem 'bcrypt',                  '3.1.13'
gem 'faker',                   '2.1.2'
gem 'will_paginate',           '3.1.8'
# gem 'bootstrap-will_paginate', '1.0.0'
gem 'will_paginate-bootstrap4'
gem 'puma',                    '4.3.5'
gem 'sass-rails',              '6.0.0'
gem 'webpacker',               '4.2.2'
gem 'turbolinks',              '5.2.1'
gem 'jbuilder',                '2.10.0'
gem 'bootsnap',                '1.4.6', require: false
# エラー日本語化
gem 'rails-i18n',              '~> 6.0'

group :development, :test do
  gem 'sqlite3',               '1.4.2'
  gem 'byebug',                '11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails' #テスト用 "Rspec"
  gem 'factory_bot_rails' #テスト用
end

group :development do
  gem 'web-console',           '4.0.2'
  gem 'listen',                '3.2.1'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'capybara',              '3.32.2'
  gem 'selenium-webdriver',    '3.142.7'
  gem 'webdrivers',            '4.3.0'
  # gem 'rails-controller-testing', '1.0.4'
end

group :production do
  gem 'pg', '1.2.3'
end

# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
