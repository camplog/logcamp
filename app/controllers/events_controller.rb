class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events.order('created_at DESC').page(params[:page]).per(15)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(safe_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(safe_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params[:query].present?
      if params[:application_id].present?
        # app#show view
        # restrict events to current app events only
        @application = Application.find(params[:application_id])
        @events = Event.search_by_keyword(params[:query])
                       .where('events.application_id = ?', @application.id)
                       .page(params[:page]).per(15)
      else
        # events#index view
        # get all events users can see based on app. memberships
        @events = Event.search_by_keyword(params[:query])
                       .where('events.application_id IN (?)', current_user.applications.ids)
                       .page(params[:page]).per(15)
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def safe_params
      params.require(:event).permit(:status, :message, :date)
    end

end
