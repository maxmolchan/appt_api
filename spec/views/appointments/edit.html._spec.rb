require 'spec_helper'

describe "appointments/edit" do
  before(:each) do
    @appointment = assign(:appointment, stub_model(Appointment,
      :first_name => "MyString",
      :last_name => "MyString",
      :comments => "MyString"
    ))
  end

  it "renders the edit appointment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do
      assert_select "input#appointment_first_name[name=?]", "appointment[first_name]"
      assert_select "input#appointment_last_name[name=?]", "appointment[last_name]"
      assert_select "input#appointment_comments[name=?]", "appointment[comments]"
    end
  end
end
