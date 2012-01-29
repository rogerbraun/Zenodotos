# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  before_filter :authenticate_admin_user!
  layout "admin"

  def index
    @last_reminder_date = ReminderDecorator.new(Reminder.order("send_date DESC").first).send_date

  end
end
