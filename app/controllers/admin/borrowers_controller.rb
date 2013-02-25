# -*- encoding : utf-8 -*-
class Admin::BorrowersController < Admin::AdminController

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    session[:search] = params[:search]
    @sort_order = params[:sort_order] || 'id'
    @page = params[:page] || 0
    @borrowers = (params[:search] ? Borrower.search(params[:search]) : Borrower).order(@sort_order).page(@page)
    @borrowers = BorrowerDecorator.decorate(@borrowers)
    flash[:notice] = "Nichts gefunden..." if @borrowers.size == 0
  end

  def send_overdue_reminders
    if admin_user_signed_in?
      Borrower.send_overdue_reminders
    end
    redirect_to admin_lendings_path, :notice => "Nutzer wurden gemahnt."
  end

  def edit
    @borrower = Borrower.find(params[:id])
  end

  def show 
    redirect_to :action => "edit"
  end

  def new
    @borrower = Borrower.new
  end

  def create
    @borrower = Borrower.new(params[:borrower])
    if @borrower.save
      redirect_to admin_borrowers_path, notice: "Entleiher gespeichert."
    else
      redirect_to :back, notice: "Entleiher konnte nicht gespeichert werden."
    end
  end

  def update 
    @borrower = Borrower.find(params[:id])
    respond_to do |format|
      if @borrower.update_attributes(params[:borrower])
        format.html { redirect_to admin_borrowers_path, notice: 'Entleiher wurde gespeichert!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @borrower = Borrower.find(params[:id])
    @borrower.unreturned.each(&:return)
    @borrower.destroy
    redirect_to admin_borrowers_path, notice: "Entleiher wurde gelöscht"
  end

end
