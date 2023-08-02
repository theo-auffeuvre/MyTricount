class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = current_user.expenses
  end

  def new
    @activity = Activity.find(params[:activity_id])
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.save!
    redirect_to root_path
  end

  def show; end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :date, :participant_id)
  end
end
