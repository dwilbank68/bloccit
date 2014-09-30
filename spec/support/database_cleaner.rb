RSpec.configure do |config| # bloc-io's version

  # Empty the database before each test file
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

# RSpec.configure do |config| # Avi's version
#
#   config.before(:suite) do
#     DatabaseCleaner.clean_with(:truncation)
#   end
#
#   config.before(:each) do
#     DatabaseCleaner.strategy = :transaction
#   end
#
#   config.before(:each, :js => true) do
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   config.before(:each) do
#     DatabaseCleaner.start
#   end
#
#   config.after(:each) do
#     DatabaseCleaner.clean
#   end
#
# end