require 'active_record'
require 'rspec'
require 'division'
require 'employee'
require 'project'
require 'pg'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Division.all.each { |division| division.destroy }
    Employee.all.each { |employee| employee.destroy }
    Project.all.each { |project| project.destroy }
  end
end
