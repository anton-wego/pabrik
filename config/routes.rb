Rails.application.routes.draw do
  scope '/admin' do
  	get '/slips/get_absensi' => 'admin/slips#get_absensi'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "admin/dashboard#index"
end
