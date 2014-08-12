require 'spec_helper'


describe Employee do
  it "has many employees" do
    division = Division.create({:name => "janitorial"})
    employee = Employee.create({:name => "Rusty", :division_id => division.id})

    employee.division.should eq division
  end
end
