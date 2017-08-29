require 'pry'
class ExpenseReportsController < ApplicationController
  before_action :set_expense_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  layout "print", only: [:summary_report]

  def index
    if pundit_user.is_admin? or pundit_user.has_role? :bookkeeper
      @users = User.all
      @users << Admin.all
    else
      @users = [pundit_user] 
    end
    @q = ExpenseReport.ransack(params[:q])
    @expense_reports = policy_scope(@q.result.page(params[:page]))
  end

  def new
    @expense_report = ExpenseReport.new
    authorize @expense_report
  end

  def create
    @expense_report = ExpenseReport.new(expense_report_params)
    if pundit_user.is_admin?
      @expense_report.admin = pundit_user
    else
      @expense_report.user = pundit_user
    end
    authorize @expense_report
    if @expense_report.save 
      redirect_to @expense_report, notice: "Expense Report was successfully created."
    else
      render :new
    end
  end

  def show
    authorize @expense_report
  end

  def edit
    authorize @expense_report
  end

  def update 
    authorize @expense_report
    if @expense_report.update(expense_report_params)
      redirect_to @expense_report, notice: "Expense Report was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @expense_report
    @expense_report.destroy
    redirect_to expense_reports_url, notice: "Expense Report was successfully destroyed."
  end

  def create_summary_report
    if pundit_user.is_admin? or pundit_user.has_role? :bookkeeper
      @users = User.all
      @users << Admin.all
    else
      @users = [pundit_user] 
    end
    @q = ExpenseReport.ransack(params[:q])
    @expense_reports = @q.result.page(params[:page])
  end

  def summary_report
    @q = ExpenseReport.ransack(params[:q])
    @expense_reports = policy_scope(@q.result.page(params[:page]))
    @total = 0
    @expense_reports.each do |report|
      @total += report.amount
    end
      
  end

  private 
    def set_expense_report
      @expense_report = ExpenseReport.find(params[:id])
    end

    def expense_report_params
      params.require(:expense_report).permit(:user_id, :admin_id, :date, :amount, :vendor, :category,
                                             :note, :other_note, :payment_method)
    end
end
