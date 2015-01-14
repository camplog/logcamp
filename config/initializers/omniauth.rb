Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:centralid,
           ENV['OAUTH2_CLIENT_ID'],
           ENV['OAUTH2_CLIENT_SECRET'])
           # client_options: {
           #   site: 'http://localhost:3029'
           # })
           # provider_ignores_state: true)
           # provider_ignores_state is a hack for CSRF issue. See details below
           # https://github.com/intridea/omniauth-oauth2/issues/58
end

# Provide a way to change default behaviour when user denies access
# Check oauths_controller#failure for more details
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}