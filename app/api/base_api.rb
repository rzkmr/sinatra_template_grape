Dir["#{ROOT_PATH}/app/api/example_api.rb"].each {|file| require_relative(file)}

class BaseAPI < Grape::API

  prefix 'api'
  format :json

  rescue_from :all do |exception|
    ErrorNotifier.notify_error_tracker(exception)
  end

  helpers do
    def resource_not_found_error
      error!('Unable to find requested resource', 404)
    end

    def success_message(message)
      {
        code: 200,
        status: 200,
        message: message
      }
    end

    def received_successfully(identifier)
      {
        resource_id: identifier,
        message: "File received for processing"
      }
    end

    def error_message(message, errors = nil)
      error_hash = {
        code: 400,
        status: 400,
        message: message
      }
      error_hash['errors'] = errors if errors.present?
      error_hash
    end

    def parse_body(params)
      params = request.body.read
      JSON.parse(params).with_indifferent_access
    end

    def request_log_data
      "#{env['REQUEST_METHOD']}::#{env['PATH_INFO']}::#{env['QUERY_STRING']}"
    end

    def authenticate
      api_key = request.env['HTTP_X_API_TOKEN'] || ''
      api_key_valid = ApiKey.authorize(api_key)
      return if api_key_valid
      error!({ message: 'Unauthorized. Invalid API token.' }, 401)
    end
  end

  # before do
  #   authenticate
  # end

  mount ExampleAPI
end
