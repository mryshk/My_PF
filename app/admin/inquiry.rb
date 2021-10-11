ActiveAdmin.register Inquiry do
  permit_params :name, :email, :message
end