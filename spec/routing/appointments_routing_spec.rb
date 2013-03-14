require "spec_helper"

describe AppointmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/appointments").should route_to("appointments#index")
    end

    it "routes to #show" do
      get("/appointments/1").should route_to("appointments#show", :id => "1")
    end

    it "routes to #create" do
      post("/appointments").should route_to("appointments#create")
    end

    it "routes to #update" do
      put("/appointments/1").should route_to("appointments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/appointments/1").should route_to("appointments#destroy", :id => "1")
    end

  end
end
