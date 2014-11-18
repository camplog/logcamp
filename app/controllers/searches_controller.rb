class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def index
    @searches = current_user.searches.order('name')
  end

  def show
    filtered_applications_ids = current_user.applications.ids
    @events = Event.search_by_keyword(@search.criteria).where(application_id: filtered_applications_ids).page(params[:page]).per(15)
  end

  def new
    @search = Search.new
  end

  def edit
  end

  def create
    @search = Search.new(safe_params)
    @search.user_id = current_user.id

    respond_to do |format|
      if @search.save
        format.html { redirect_to root_path, notice: 'Search was successfully created. Here is what we found matching.' }
        format.json { render :show, status: :created, location: @search }
        format.js
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @search.update(safe_params)
        format.html { redirect_to root_path, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

    def set_search
      @search = Search.find(params[:id])
    end

    def safe_params
      params.require(:search).permit(:name, :color, :criteria)
    end
end
