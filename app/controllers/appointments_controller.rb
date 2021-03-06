class AppointmentsController < ApplicationController
  
  def index
    @appointments = Appointment.all
    render json: @appointments, status: 200, location: @appointment
  end

  def list
    @appointments = Appointment.filter_by_date(params[:start], params[:end])
    render json: @appointments, status: 200, location: @appointment
  end

  def create
    @appointment = Appointment.new(params[:appointment])

    if @appointment.dates_valid?(params[:appointment][:start_time], params[:appointment][:end_time])
      @appointment.save
      @appointments = Appointment.all
      render json: @appointments, status: 200, location: @appointment
    else
      render json: { :errors => 'Dates are not valid'.as_json }, status: 422
    end
  end
 
  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.dates_valid?(params[:appointment][:start_time], params[:appointment][:end_time])
      @appointment.update_attributes(params[:appointment])
      @appointments = Appointment.all
      render json: @appointments, status: 200, location: @appointment
    else
      render json: { :errors => 'Error while updating'.as_json }, status: 422
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    @appointments = Appointment.all
    render json: @appointments, status: 200, location: @appointment
  end
end
