Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'
  resource :messages do
    collection do
      post 'reply'
    end
  end
end
