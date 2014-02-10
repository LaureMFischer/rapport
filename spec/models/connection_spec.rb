require 'spec_helper'

describe Connection do
  it "is invalid without a first name" do
    expect(Connection.create(last_name: "Fisher", headline: "Programmer")).to_not be_valid
  end

  it "is invalid without a last name" do
    expect(Connection.create(first_name: "David", headline: "Programmer")).to_not be_valid
  end

  it "is invalid without a headline" do
    expect(Connection.create(first_name: "David", last_name: "Fisher")).to_not be_valid
  end

  it "is invalid without a user id" do
    expect(Connection.create(first_name: "David", last_name: "Fisher", headline: "Programmer")).to_not be_valid
  end
end
