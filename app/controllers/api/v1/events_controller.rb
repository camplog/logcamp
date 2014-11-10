module Api
  module V1
    class EventsController < Api::BaseController

      # curl http://localhost:3023/api/events -H 'Authorization: Token token="111"'
      # curl http://localhost:3023/api/events?q=429 -H 'Authorization: Token token="111"'
      def index
        @events = @current_application.events.order('created_at DESC').limit(20)
        if params[:q].present?
          @events = @current_application.events.search_by_keyword(params[:q])
        end
        render json: @events, status: 200
      end

      # curl http://localhost:3023/api/events/:id -H 'Authorization: Token token="111"'
      def show
        @event = Event.find(params[:id])
        render json: @event, status: 200
      end

      # curl -v -H 'Authorization: Token token="111"' -H "Content-type: application/json" -X POST -d '{"event": {"status": "warning", "message": "Running low on fuel", "metadata": {"color": "pink", "sport": "basket-ball", "age": 25, "fruit": "banana"} }}' http://localhost:3023/api/events
      def create
        @event = @current_application.events.new(safe_params)
        if @event.save
          render @event.as_json, status: :created
          #render json: @event, status: :created
          EventMailer.notify_members(@event).deliver_later if @event.alert?
        else
          render json: @event.errors, status: 422
          puts "**** #{@event.errors.full_messages.to_sentence} ****"
        end
      end

      private

        def safe_params
          params.require(:event).permit(:status, :message, :alert, :metadata)
        end

    end
  end
end