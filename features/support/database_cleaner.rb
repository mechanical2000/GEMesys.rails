require "database_cleaner"

Cucumber::Rails::Database.autorun_database_cleaner = false
Cucumber::Rails::Database.javascript_strategy      = :truncation

After do |_scenario, _block|
  DatabaseCleaner.clean_with(:truncation, except: Agilibox::CucumberConfig.databasecleaner_tables)
end
