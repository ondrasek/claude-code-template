# Ruby Development Guidelines

This file contains Ruby-specific development guidelines for Claude Code.

## Ruby Version Management

### Using rbenv or RVM
```bash
# rbenv
rbenv install 3.2.2
rbenv local 3.2.2

# RVM
rvm install 3.2.2
rvm use 3.2.2
```

### Bundler for Dependencies
```bash
gem install bundler
bundle init                    # Create Gemfile
bundle install                 # Install dependencies
bundle update                  # Update dependencies
bundle exec rake              # Run commands in bundle context
```

### Gemfile Configuration
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

## Project Structure

### Ruby Gem Structure
```
my_gem/
├── lib/
│   ├── my_gem.rb              # Main file
│   └── my_gem/
│       ├── version.rb
│       └── core.rb
├── spec/                      # RSpec tests
│   ├── spec_helper.rb
│   └── my_gem_spec.rb
├── bin/                       # Executables
├── Gemfile
├── Gemfile.lock
├── my_gem.gemspec
├── Rakefile
└── README.md
```

### Rails Application Structure
```
rails_app/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   ├── helpers/
│   ├── mailers/
│   └── jobs/
├── config/
│   ├── routes.rb
│   ├── database.yml
│   └── application.rb
├── db/
│   ├── migrate/
│   └── schema.rb
├── spec/                      # RSpec tests
├── Gemfile
└── Rakefile
```

## Ruby Conventions

### Naming Conventions
```ruby
# Classes and modules: CamelCase
class UserAccount
  module Authentication
  end
end

# Methods and variables: snake_case
def calculate_total_price
  user_name = "John"
end

# Constants: SCREAMING_SNAKE_CASE
MAX_RETRY_COUNT = 3
API_VERSION = "v1"

# Predicates end with ?
def valid?
  !expired? && active?
end

# Dangerous methods end with !
def save!
  save || raise(RecordNotSaved)
end
```

### Ruby Idioms
```ruby
# Use symbols for hash keys
user = { name: "Alice", age: 30 }

# Use ||= for memoization
def expensive_calculation
  @result ||= perform_calculation
end

# Use &. (safe navigation)
user&.profile&.name

# Use trailing if/unless
process_order if order.valid?
return unless user.authorized?

# Use tap for object configuration
User.new.tap do |u|
  u.name = "Bob"
  u.email = "bob@example.com"
  u.save!
end
```

## Object-Oriented Patterns

### Class Definition
```ruby
class User
  # Class variables (avoid when possible)
  @@count = 0
  
  # Class methods
  class << self
    def find_by_email(email)
      # Implementation
    end
  end
  
  # Alternative class method syntax
  def self.active
    where(active: true)
  end
  
  # Instance variables
  attr_reader :id, :name
  attr_accessor :email
  attr_writer :password
  
  def initialize(name:, email:)
    @name = name
    @email = email
    @@count += 1
  end
  
  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end
  
  private
  
  def validate_email
    # Private method
  end
end
```

### Modules and Mixins
```ruby
module Trackable
  extend ActiveSupport::Concern
  
  included do
    has_many :activities
    scope :recent, -> { order(created_at: :desc) }
  end
  
  def track_activity(action)
    activities.create(action: action)
  end
  
  module ClassMethods
    def tracked_since(date)
      joins(:activities).where('activities.created_at > ?', date)
    end
  end
end

class User
  include Trackable
end
```

## Error Handling

### Exception Handling
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
class AuthenticationError < ApplicationError; end

# Raising exceptions
raise ValidationError, "Invalid email format" unless valid_email?(email)
```

### Retry Pattern
```ruby
def fetch_with_retry(url, max_retries: 3)
  retries = 0
  begin
    HTTP.get(url)
  rescue Net::HTTPError => e
    retries += 1
    if retries < max_retries
      sleep(2 ** retries)  # Exponential backoff
      retry
    else
      raise
    end
  end
end
```

## Testing with RSpec

### Basic RSpec Structure
```ruby
# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  
  describe 'associations' do
    it { should have_many(:posts) }
    it { should belong_to(:organization) }
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

### Testing Controllers
```ruby
RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }
    
    before { get :show, params: { id: user.id } }
    
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'assigns the requested user' do
      expect(assigns(:user)).to eq(user)
    end
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { user: attributes_for(:user) } }
      
      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end
    end
  end
end
```

### Test Doubles and Mocks
```ruby
RSpec.describe OrderService do
  describe '#process' do
    let(:order) { create(:order) }
    let(:payment_gateway) { instance_double(PaymentGateway) }
    
    before do
      allow(PaymentGateway).to receive(:new).and_return(payment_gateway)
    end
    
    it 'charges the payment gateway' do
      expect(payment_gateway).to receive(:charge)
        .with(order.total, order.payment_method)
        .and_return(true)
      
      described_class.new(order).process
    end
  end
end
```

## Metaprogramming

### Dynamic Method Definition
```ruby
class DynamicModel
  # define_method
  [:created, :updated, :deleted].each do |status|
    define_method "#{status}?" do
      self.status == status.to_s
    end
  end
  
  # method_missing
  def method_missing(method_name, *args, &block)
    if method_name.to_s.start_with?('find_by_')
      attribute = method_name.to_s.gsub('find_by_', '')
      self.class.where(attribute => args.first)
    else
      super
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('find_by_') || super
  end
end
```

### Class Macros
```ruby
module Timestampable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def with_timestamps(*fields)
      fields.each do |field|
        define_method "#{field}_at" do
          instance_variable_get("@#{field}_at")
        end
        
        define_method "set_#{field}_timestamp" do
          instance_variable_set("@#{field}_at", Time.current)
        end
      end
    end
  end
end

class Document
  include Timestampable
  with_timestamps :published, :archived
end
```

## Performance Optimization

### Benchmarking
```ruby
require 'benchmark'

n = 1000000
Benchmark.bm do |x|
  x.report("map:")    { n.times.map { |i| i * 2 } }
  x.report("collect:") { n.times.collect { |i| i * 2 } }
  x.report("each:")   { arr = []; n.times.each { |i| arr << i * 2 } }
end

# Using benchmark-ips for iterations per second
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report("Symbol#to_s") { :symbol.to_s }
  x.report("String#to_sym") { "string".to_sym }
  x.compare!
end
```

### Memory Profiling
```ruby
require 'memory_profiler'

report = MemoryProfiler.report do
  # Code to profile
  1000.times { User.new(name: "Test") }
end

report.pretty_print
```

## Rails Best Practices

### Active Record Optimization
```ruby
# N+1 query problem
# Bad
users = User.all
users.each { |user| puts user.posts.count }

# Good - includes
users = User.includes(:posts)
users.each { |user| puts user.posts.size }

# Good - counter cache
class User < ApplicationRecord
  has_many :posts, counter_cache: true
end

# Batch processing
User.find_each(batch_size: 1000) do |user|
  user.process!
end

# Select only needed columns
User.select(:id, :name, :email).where(active: true)
```

### Service Objects
```ruby
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
    OpenStruct.new(success?: false, user: e.record, errors: e.record.errors)
  end
  
  private
  
  def send_welcome_email(user)
    UserMailer.welcome(user).deliver_later
  end
  
  def create_default_settings(user)
    user.create_settings(theme: 'default', notifications: true)
  end
end

# Usage
result = UserRegistrationService.new(user_params).call
```

## Code Quality Tools

### RuboCop Configuration
```yaml
# .rubocop.yml
AllCops:
  NewCops: enable
  TargetRubyVersion: 3.2
  Exclude:
    - 'db/**/*'
    - 'vendor/**/*'
    - 'node_modules/**/*'

Style/Documentation:
  Enabled: false

Style/StringLiterals:
  EnforcedStyle: double_quotes

Metrics/MethodLength:
  Max: 20

Metrics/ClassLength:
  Max: 200
```

### Code Quality Commands
```bash
# RuboCop for style
bundle exec rubocop
bundle exec rubocop -a  # Auto-fix

# Reek for code smells
bundle exec reek

# Brakeman for security
bundle exec brakeman

# SimpleCov for coverage
# Add to spec_helper.rb:
require 'simplecov'
SimpleCov.start 'rails'
```

## Best Practices

1. **Follow Ruby Style Guide** - https://rubystyle.guide/
2. **Use semantic versioning** for gems
3. **Write tests first** (TDD/BDD approach)
4. **Keep methods small** - under 10 lines ideally
5. **Use descriptive names** - be explicit
6. **Avoid monkey patching** core classes
7. **Prefer composition** over inheritance
8. **Use frozen string literals** - add magic comment
9. **Document public APIs** with YARD
10. **Profile before optimizing** - measure first

## Integration with Claude Code

When working with Ruby projects:
- Use the `patterns` agent for Ruby idioms
- Use the `researcher` agent for gem discovery
- Use the `principles` agent for OOP design
- Use the `complete` agent for error handling
- Use the `docsync` agent for YARD documentation