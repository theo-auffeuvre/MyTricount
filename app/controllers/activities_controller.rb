class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_is_participant, only: %i[show edit update destroy]
  before_action :set_activity, only: %i[show edit update destroy]

  def index
    @activities = current_user.activities.order(created_at: :desc)
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
    @expenses = @activity.expenses.order(date: :desc)
    @balances = get_balances(@participants, @expenses)
    @statements = get_statements(@balances)
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def check_user_is_participant
    @activity = Activity.find(params[:id])
    Participant.create!(user: current_user, activity: @activity) if @activity.participants.select{|p| p.user == current_user}.empty?
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :currency, :category)
  end

  def get_balances(participants, expenses)
    expenses_by_participants = {}
    participants.each do |participant|
      expenses_by_participants[participant.user] = 0
    end
    expenses.each do |expense|
      expenses_by_participants[expense.participant.user] += expense.amount
    end
    
    expenses_average = expenses_by_participants.values.sum / participants.count
    
    adjustments = {}
    expenses_by_participants.each do |participant, amount|
      adjustments[participant] = expenses_average - amount
    end

    participants_give = adjustments.select{|participant, amount| amount > 0}
    participants_receive = adjustments.select{|participant, amount| amount < 0}

    balances = []
    participants_give.each do |participant_give, amount_give|
      participants_receive.each do |participant_receive, amount_receive|
        amount_to_give = [amount_give, -amount_receive].min

        # Mettre à jour les montants des participants
        adjustments[participant_give] -= amount_to_give
        adjustments[participant_receive] += amount_to_give

        balances << {from: participant_give, to: participant_receive, amount: amount_to_give}
      end
    end
    balances
  end

  def get_statements(balances)
    statements = Hash.new(0)
    balances.each do |balance|
      statements[balance[:from]] -= balance[:amount]
      statements[balance[:to]] += balance[:amount]
    end
    statements
  end
end
