#encoding: utf-8
ActiveAdmin.register Borrower do
  index do
    column :id
    column :name
    column :email
    column :matrikelnr
    default_actions
  end

 # show do
  #  render "show"
  #end

  sidebar :actions, :only => :show do 
    render "sidebar"
  end

  member_action :return_all_books, :method => :post do
    borrower = Borrower.find(params[:id])
    borrower.return_all_books
    redirect_to admin_borrower_path(borrower), :notice => "Bücher wurden zurückgegeben"
  end

  controller do
    def user_for_paper_trail
      current_admin_user
    end
  end

end
