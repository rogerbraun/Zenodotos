#encoding: utf-8
class Admin::LendingsController < Admin::AdminController
  def return_lending
    @lendings.update_all(returned: true)
    redirect_to :back, notice: "#{@lendings.count} Bücher zurück gegeben."
  end

  def extend_lending
    @return_date = params[:return_date] || Date.today + 28.days
    @lendings.update_all(return_date: @return_date)
    redirect_to :back, notice: "#{@lendings.count} Bücher verlängert."
  end

  def return_or_extend
    @lendings = Lending.where("id in (?)", params[:lending_ids])
    if params["return"]
      return_lending
    elsif params["extend"]
      extend_lending
    end
  end


end
