require 'spec_helper'

describe Appointment do

  before do
    @appt_1 = Appointment.create(first_name:'A_1', last_name:'B_1', start_time: '2013-03-01T09:30:00Z', end_time: '2013-03-01T10:30:00Z')
    @appt_2 = Appointment.create(first_name:'A_2', last_name:'B_2', start_time: '2013-03-01T10:35:00Z', end_time: '2013-03-01T11:35:00Z')
    @appt_3 = Appointment.create(first_name:'A_3', last_name:'B_3', start_time: '2013-03-01T11:40:00Z', end_time: '2013-03-01T11:55:00Z')
  end

  describe "filter appt by dates" do

    it "should return first two appts" do
      appt = Appointment.filter_by_date(nil, '2013-03-01T11:35:00Z')
      appt.should == [@appt_1, @appt_2]
    end

    it "should return last appt" do
      appt = Appointment.filter_by_date('2013-03-01T11:40:00Z', nil)
      appt.should == Array(@appt_3)
    end

    it "should return last two appts" do
      appt = Appointment.filter_by_date('2013-03-01T10:35:00Z', '2013-04-01T11:55:00Z')
      appt.should == [@appt_2, @appt_3]
    end

    it "should return all appts" do
      appt = Appointment.filter_by_date(nil,nil)
      appt.should == [@appt_1, @appt_2, @appt_3]
    end
  end

  describe "validate dates" do

   before do
      @appt = Appointment.new()
   end
 
    it "should be invalid" do
      @appt.dates_valid?(nil, nil).should_not be_true
    end

    it "should be invalid" do
      @appt.dates_valid?('2013-03-01T10:35:00Z', nil).should_not be_true
    end

    it "should be invalid" do
      @appt.dates_valid?(nil, '2013-03-01T10:35:00Z').should_not be_true
    end
    
    it "should be invalid" do
      @appt.dates_valid?('2013-03-01T10:35:00Z', '2013-03-01T10:55:00Z').should_not be_true
    end
    
    it "should be invalid" do
      @appt.dates_valid?('2013-03-01T10:35:00Z', '2013-03-01T09:55:00Z').should_not be_true
    end
        
    it "Dates not in future: should be invalid" do
      @appt.dates_valid?('2011-03-01T10:35:00Z', '2019-03-01T09:55:00Z').should_not be_true
    end
           
    it "dates ovelap: should be invalid" do
      @appt.dates_valid?('2013-03-01T01:35:00Z', '2013-03-01T10:45:00Z').should_not be_true
    end

    it "dates no not ovelap: should be valid" do
      @appt.dates_valid?('2013-04-01T01:35:00Z', '2013-04-01T10:45:00Z').should be_true
    end

  end

end
