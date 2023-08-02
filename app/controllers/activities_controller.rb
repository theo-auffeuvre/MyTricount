class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show edit update destroy]

  def index
    @activities = current_user.activities
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.save!
    @participant = Participant.new(user: current_user, activity: @activity)
    @participant.save!
    redirect_to root_path
  end

  def show
    @participants = @activity.participants
    @expenses = @activity.expenses
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :currency, :category)
  end
end
