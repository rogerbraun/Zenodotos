ActiveAdmin.register Book do

  index do
    column :id
    column :titel
    column :autor
    column :signatur
    column :nebensignatur
    column :created_at

    default_actions
  end
  
end
