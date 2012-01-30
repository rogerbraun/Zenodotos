#encoding: utf-8
class Admin::LendingsController < Admin::AdminController
  def return
    @lendings = Lending.where("id in (?)", params[:lending_ids])
    @lendings.update_all(returned: true)
    redirect_to :back, notice: "#{@lendings.count} Bücher zurück gegeben."
  end
end
