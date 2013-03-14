require 'spec_helper'

describe AppointmentsController do

  before do
    @appt = Appointment.create(first_name:'A', last_name:'B', start_time: '2013-03-01T09:30:00Z', end_time: '2013-04-01T09:30:00Z')
    @appt_2 = Appointment.create(first_name:'A_2', last_name:'B_2', start_time: '2015-03-01T09:30:00Z', end_time: '2015-04-01T09:30:00Z')
  end

  it 'should return 200 on list action' do
    get 'list'
    response.code.should eql('200')
    response.body.should eql(Appointment.all.to_json)
    Appointment.all.count.should eql(2)
  end
  
   it 'should return 422 on create action and json with an error' do
    post 'create', {appointment: {first_name:'A', last_name:'B', start_time: '2013-03-01T09:30:00Z', end_time: '2013-04-01T09:30:00Z'}}
    response.code.should eql('422')
    response.body.should eql({ :errors => 'Dates are not valid'.as_json }.to_json)
  end
  
  it 'should return 200 on create action' do
    post 'create', {appointment: {first_name:'AAA', last_name:'B', start_time: '2013-04-01T11:30:00Z', end_time: '2013-04-01T12:30:00Z'}}
    response.code.should eql('200')
    response.body.should eql(Appointment.all.to_json)
    Appointment.last.first_name.should eql('AAA')
  end
   
   it 'should return 200 on update action' do
    put 'update', {id: @appt.id, appointment: {first_name:'AA', last_name:'BB', start_time: '2016-03-01T09:30:00Z', end_time: '2016-04-01T09:30:00Z'}}
    response.code.should eql('200')
    Appointment.find(@appt.id).first_name.should eql('AA')
    Appointment.all.count.should eql(2)
  end
  
  it 'should return 422 on update action and json with an error' do
    put 'update', {id: @appt.id, appointment: {first_name:'AA', last_name:'BB', start_time: '2013-03-01T09:30:00Z', end_time: '2016-04-01T09:30:00Z'}}
    response.code.should eql('422')
    response.body.should eql({ :errors => 'Error while updating'.as_json }.to_json)
    Appointment.find(@appt.id).first_name.should eql('A')
    Appointment.all.count.should eql(2)
  end
  
   it 'should return 200 on delete action' do
    delete 'destroy', id:@appt.id
    response.code.should eql('200')
    response.body.should eql(Appointment.all.to_json)
    Appointment.all.count.should eql(1)
    Appointment.last.first_name.should eql('A_2')
  end
  
end
