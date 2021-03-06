require "rails_helper"

RSpec.describe SearchesController, :type => :controller do

  let(:current_user) { FactoryGirl.create(:user) }

  describe "GET #show/:id" do
    include ControllerHelper

    before do
      @search = FactoryGirl.create :search, user: current_user
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @search.id
      expect(response).to be_success
    end

    it "renders the index template searches/show" do
      get :show, id: @search.id
      expect(response).to render_template("searches/show")
    end

    it "load all events with search criteria" do
      application_owner = FactoryGirl.create :application, owner: current_user, members: [current_user]
      application_other = FactoryGirl.create :application, owner: FactoryGirl.create(:user)
      create_events application_other
      events = create_events application_owner

      get :show, id: @search.id
      expect(assigns(:events)).to match_array(events)
    end

  end
end