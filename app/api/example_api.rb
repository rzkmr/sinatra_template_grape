class ExampleAPI < Grape::API
  resources :exmple do
    desc 'testing api'
    get '/' do
      {status: 'ok', message: 'Welcome to example api'}
    end
  end
end
