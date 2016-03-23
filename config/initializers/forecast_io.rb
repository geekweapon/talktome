ForecastIO.configure do |configuration|
  configuration.api_key = Rails.application.secrets.forecast_io_api_key
end
