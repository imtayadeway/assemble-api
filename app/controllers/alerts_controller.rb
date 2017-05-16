class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :update, :destroy]

  # GET /alerts
  def index
    @team = Team.find(alert_params["team_id"]) if alert_params["team_id"]

    @alerts = @team ? @team.alerts : Alert.all

    render json: @alerts
  end

  # GET /alerts/1
  def show
    render json: @alert
  end

  # POST /alerts
  def create
    team = Team.find(params[:team_id])
    @alert = team.alerts.new(alert_params)

    if @alert.save
      render json: @alert, status: :created, location: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alerts/1
  def update
    if @alert.update(alert_params)
      render json: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alerts/1
  def destroy
    @alert.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(
        params,
        only: [:"alert-text", :"alert-location"]
      )
    end
end
