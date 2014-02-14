require 'spec_helper'

describe Note do
  it "is invalid without a body" do
    expect(Note.create(date_of_interaction: 'April 1, 2013')).to_not be_valid
  end

  it "is invalid without a date of interaction" do
    expect(Note.create(body: 'This is a note.')).to_not be_valid
  end

  describe "associations" do
    it { should belong_to :connection}
  end
end
