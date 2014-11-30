require 'rails_helper'

RSpec.describe "entries/index", :type => :view do
  before(:each) do
    assign(:entries, [
      Entry.create!(
        :description => "Description"
      ),
      Entry.create!(
        :description => "Description"
      )
    ])
  end

  it "renders a list of entries" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
