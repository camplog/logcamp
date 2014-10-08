class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  def index
    @applications = current_user.applications.order('name')
  end

  def show
  end

  def new
    @application = Application.new
  end

  def edit
  end

  def create
    @application = Application.new(safe_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @application.update(safe_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_application
      @application = Application.find(params[:id])
    end

    def safe_params
      params.require(:application).permit(:name, :slug)
    end
end
