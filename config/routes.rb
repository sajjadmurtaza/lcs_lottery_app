# frozen_string_literal: true

# config/routes.rb

Rails.application.routes.draw do
  get 'lottery/index'
  post 'lottery/index', to: 'lottery#upload_csv'
  root 'lottery#index'
  get 'download_csv', to: 'lottery#download_csv', as: 'download_csv'
end
