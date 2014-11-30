require 'rails_helper'

RSpec.describe "entries/show", :type => :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
  end
end
