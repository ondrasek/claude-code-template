# Ruby Development Reference

Essential Ruby development guidelines for Claude Code projects.

## Version Management
```bash
# rbenv
rbenv install 3.2.2
rbenv local 3.2.2

# RVM  
rvm install 3.2.2
rvm use 3.2.2

# Bundler
gem install bundler
bundle install
bundle update
bundle exec rake
```

## Gemfile
```ruby
source 'https://rubygems.org'
ruby '3.2.2'

gem 'rails', '~> 7.0'
gem 'pg', '~> 1.4'
gem 'puma', '~> 6.0'

group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'pry-byebug'
  gem 'rubocop', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'simplecov', require: false
end
```

## Ruby Conventions
```ruby
# Classes: PascalCase
class UserAccount; end

# Methods and variables: snake_case
def calculate_total_price
  user_name = "John"
end

# Constants: SCREAMING_SNAKE_CASE
MAX_RETRY_COUNT = 3

# Predicates end with ?
def valid?
  !expired? && active?
end

# Dangerous methods end with !
def save!
  save || raise(RecordNotSaved)
end
```

## Common Patterns
```ruby
# Use symbols for hash keys
user = { name: "Alice", age: 30 }

# Memoization with ||=
def expensive_calculation
  @result ||= perform_calculation
end

# Safe navigation
user&.profile&.name

# Trailing conditionals
process_order if order.valid?
return unless user.authorized?

# Object configuration with tap
User.new.tap do |u|
  u.name = "Bob"
  u.email = "bob@example.com"
  u.save!
end
```

## Object-Oriented Design
```ruby
class User
  attr_reader :id, :name
  attr_accessor :email
  attr_writer :password
  
  def initialize(name:, email:)
    @name = name
    @email = email
  end
  
  # Class methods
  def self.find_by_email(email)
    # Implementation
  end
  
  private
  
  def validate_email
    # Private method
  end
end

# Modules and mixins
module Trackable
  extend ActiveSupport::Concern
  
  included do
    has_many :activities
  end
  
  def track_activity(action)
    activities.create(action: action)
  end
end
```

## Error Handling
```ruby
# Basic rescue
begin
  risky_operation
rescue StandardError => e
  logger.error "Operation failed: #{e.message}"
  raise
end

# Multiple rescue clauses
begin
  api_call
rescue Net::HTTPError => e
  handle_http_error(e)
rescue Timeout::Error => e
  handle_timeout(e)
rescue => e
  handle_generic_error(e)
ensure
  cleanup_resources
end

# Custom exceptions
class ApplicationError < StandardError; end
class ValidationError < ApplicationError; end

# Retry pattern with exponential backoff
def fetch_with_retry(url, max_retries: 3)
  retries = 0
  begin
    HTTP.get(url)
  rescue Net::HTTPError => e
    retries += 1
    if retries < max_retries
      sleep(2 ** retries)
      retry
    else
      raise
    end
  end
end
```

## Testing with RSpec
```ruby
# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  
  describe '#full_name' do
    let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }
    
    it 'returns the combined first and last name' do
      expect(user.full_name).to eq('John Doe')
    end
  end
  
  describe '.active' do
    let!(:active_user) { create(:user, active: true) }
    let!(:inactive_user) { create(:user, active: false) }
    
    it 'returns only active users' do
      expect(User.active).to include(active_user)
      expect(User.active).not_to include(inactive_user)
    end
  end
end
```

## Rails Patterns
```ruby
# Active Record optimization
# Bad - N+1 query
users = User.all
users.each { |user| puts user.posts.count }

# Good - includes
users = User.includes(:posts)
users.each { |user| puts user.posts.size }

# Service objects
class UserRegistrationService
  def initialize(user_params)
    @user_params = user_params
  end
  
  def call
    ActiveRecord::Base.transaction do
      user = User.create!(@user_params)
      send_welcome_email(user)
      create_default_settings(user)
      user
    end
  rescue ActiveRecord::RecordInvalid => e
    OpenStruct.new(success?: false, errors: e.record.errors)
  end
end
```

## Performance & Quality
```ruby
# Benchmarking
require 'benchmark'

Benchmark.bm do |x|
  x.report("map:") { 1000.times.map { |i| i * 2 } }
  x.report("each:") { arr = []; 1000.times.each { |i| arr << i * 2 } }
end

# Memory profiling
require 'memory_profiler'

report = MemoryProfiler.report do
  1000.times { User.new(name: "Test") }
end
report.pretty_print
```

## Code Quality Tools
```bash
# RuboCop
bundle exec rubocop
bundle exec rubocop -a  # Auto-fix

# Reek (code smells)
bundle exec reek

# Brakeman (security)
bundle exec brakeman

# SimpleCov (coverage)
# Add to spec_helper.rb:
require 'simplecov'
SimpleCov.start 'rails'
```

## Best Practices
- Follow Ruby Style Guide (https://rubystyle.guide/)
- Use semantic versioning for gems
- Write tests first (TDD/BDD approach)
- Keep methods small (under 10 lines ideally)
- Use descriptive names - be explicit
- Avoid monkey patching core classes
- Prefer composition over inheritance
- Use frozen string literals
- Document public APIs with YARD
- Profile before optimizing