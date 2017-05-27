PagSeguro.configure do |config|
  config.email       = Rails.application.secrets.PAGSEGURO_EMAIL
  config.token       = Rails.application.secrets.PAGSEGURO_TOKEN
  config.encoding    = "UTF-8"

  if Rails.env.production?
    config.environment = :production
  else
    config.environment = :sandbox
  end

end
