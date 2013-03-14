require 'spec_helper'

describe "appointments/new" do
  before(:each) do
    assign(:appointment, stub_model(Appointment,
      :first_name => "MyString",
      :last_name => "MyString",
      :comments => "MyString"
    ).as_new_record)
  end

  it "renders new appointment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", appointments_path, "post" do
      assert_select "input#appointment_first_name[name=?]", "appointment[first_name]"
      assert_select "input#appointment_last_name[name=?]", "appointment[last_name]"
      assert_select "input#appointment_comments[name=?]", "appointment[comments]"
    end
  end
end
