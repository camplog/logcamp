require "rails_helper"

RSpec.describe EventsController, :type => :controller do
  let(:current_user) { @current_user || User.first }

  before do
    @current_user = FactoryGirl.create :user

    # add events for current application
    @application = FactoryGirl.create :application, name: 'app_logcamp', owner: @current_user, members: [@current_user]
    FactoryGirl.create :event, status: 'success', application: @application
    FactoryGirl.create :event, message: 'logcamp1', application: @application
    FactoryGirl.create :event, metadata: '{"status":"error", "message": ""}', application: @application

    application_owner = FactoryGirl.create :application, name: 'app_logcamp owner', owner: @current_user, members: [@current_user]
    FactoryGirl.create :event, status: 'success', application: application_owner
    FactoryGirl.create :event, message: 'logcamp1', application: application_owner
    FactoryGirl.create :event, metadata: '{"status":"error", "message": ""}', application: application_owner

    application_other = FactoryGirl.create :application, name: 'app_logcamp other'
    FactoryGirl.create :event, status: 'success', application: application_other
    FactoryGirl.create :event, message: 'logcamp1', application: application_other
    FactoryGirl.create :event, metadata: '{"status":"error", "message": ""}', application: application_other
  end

  describe "GET #events/search" do

    def call_request query = nil
      xhr :get, :search, query: query
    end

    it "responds successfully with an HTTP 200 status code" do
      call_request
      expect(response).to be_success
    end

    it "renders the index template searches/show" do
      call_request
      expect(response).to render_template("events/search")
    end

    it "load events with query search 'status'" do
      call_request 'success'
      expect(assigns(:events).size).to eq(2)

      call_request 'logcamp1'
      expect(assigns(:events).size).to eq(2)

      call_request '{"status":"error"}'
      expect(assigns(:events).size).to eq(2)

      call_request 'app_logcamp'
      expect(assigns(:events).size).to eq(6)
    end
  end

  describe "GET #applications/:application_id/events/search" do
    def call_request query = nil
      xhr :get, :search, application_id: @application.id, query: query
    end

    it "responds successfully with an HTTP 200 status code" do
      call_request
      expect(response).to be_success
    end

    it "renders the index template searches/show" do
      call_request
      expect(response).to render_template("events/search")
    end

    it "load events with query search 'status'" do
      call_request 'success'
      expect(assigns(:events).size).to eq(1)

      call_request 'logcamp1'
      expect(assigns(:events).size).to eq(1)

      call_request '{"status":"error"}'
      expect(assigns(:events).size).to eq(1)

      call_request 'app_logcamp'
      expect(assigns(:events).size).to eq(3)
    end
  end

end