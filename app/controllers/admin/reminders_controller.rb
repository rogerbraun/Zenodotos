class Admin::RemindersController < ApplicationController

  before_filter :authenticate_admin_user!
  layout "admin"

  # GET /reminders
  # GET /reminders.json
  def index
    @reminders = ReminderDecorator.decorate(Reminder.all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.json
  def new
    @reminder = ReminderDecorator.new(Reminder.from_overdue)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = ReminderDecorator.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.json
  def create
    @reminder = Reminder.new(params[:reminder])
    binding.pry

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to [:admin, @reminder], notice: 'Reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.json
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url }
      format.json { head :no_content }
    end
  end
end
