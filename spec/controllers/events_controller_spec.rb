require "rails_helper"

RSpec.describe EventsController, :type => :controller do

  let(:current_user) { User.first }

  before do
    FactoryGirl.create :user
    @application = FactoryGirl.create :application, name: 'app_logcamp', owner: current_user, members: [current_user]
  end

  def load_events call_request
    FactoryGirl.create :event, status: 'success', application: @application
    FactoryGirl.create :event, message: 'logcamp1', application: @application
    FactoryGirl.create :event, metadata: '{"status":"error", "message": ""}', application: @application

    call_request.call 'success'
    expect(assigns(:events).size).to eq(1)

    call_request.call 'logcamp1'
    expect(assigns(:events).size).to eq(1)

    call_request.call '{"status":"error"}'
    expect(assigns(:events).size).to eq(1)

    call_request.call 'app_logcamp'
    expect(assigns(:events).size).to eq(3)
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
      load_events method(:call_request)
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
      load_events method(:call_request)
    end
  end

end