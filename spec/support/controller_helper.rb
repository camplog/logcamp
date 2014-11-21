module ControllerHelper
  def create_events application
    FactoryGirl.create_list(:event, 5, application: application)
  end
end
