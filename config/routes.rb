Rails.application.routes.draw do
  resources :procedure_categories
  get 'report/backlog'
  get 'report/waitlist'
  get 'report/surgical_service'
  get 'report/surgical_service_efficiency'
  get 'report/surgical_efficiency'
  get 'report/load_surgical_service'
  get 'report/load_surgical_service_efficiency'
  resources :surgical_services do
    collection do
      get 'surgeries_by_status_by_month'
      get 'surgical_service_efficiency_by_month'
      get 'average_procedure_duration_by_month'
      get 'load_sub_form'
      get 'load_death_reason'
    end
  end
  resources :or_schedules do
    collection do
      get 'load_patients'
      get 'load_sub_form'
      get 'today'
    end
  end
  resources :phone_calls do
    collection do
      get 'load_sub_form'
    end
  end
  resources :admissions do
    member do
      get 'admission'
    end
    collection do
      get 'patients_by_status_by_month'
      get 'load_sub_form'
      get 'load_information'
    end
  end
  resources :patients do
    collection do
      get 'appointment_list'
      get 'load_appointments'
      get 'load_age'
    end
  end
  resources :anesthesians
  resources :circulating_nurses
  resources :scrub_nurses
  resources :surgeons
  resources :schedule_orders
  resources :departments
  resources :physicians
  resources :or_tables
  resources :payment_types
  resources :procedures
  resources :diagnoses
  resources :wards
  resources :hospitals
  resources :regions
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
  }
  scope "/admin" do
    resources :users
  end
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
