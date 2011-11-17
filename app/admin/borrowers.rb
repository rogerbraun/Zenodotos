ActiveAdmin.register Borrower do
  index do
    column :id
    column :name
    column :email
    column :matrikelnr
    default_actions
  end
  
end
