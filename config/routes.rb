# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user, only: %i[index destroy create]
  delete 'user' => 'user#extended_destroy'
end
