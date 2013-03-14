require 'csv'

namespace :db do
  desc "Import csv table"
  task :csvimport do
    Rake::Task['db:reset'].invoke
    CSV.foreach("#{Rails.root}/db/appt_data.csv", :headers => true) do |row|
      Appointment.create!(row.to_hash)
    end
  end
end