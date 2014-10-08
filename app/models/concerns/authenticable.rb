module Authenticable
  extend ActiveSupport::Concern

  private

	def self.setup_provider_account(user, auth_hash)
		authentication = user.authentications.find_or_create_by(provider: auth_hash.provider, uid: auth_hash.uid)
		case auth_hash.provider
    when 'github', 'github_enterprise'
      authentication.provider_token    = auth_hash.credentials.token
      authentication.provider_username = auth_hash.extra.raw_info.login
      authentication.support_etag      = true
      authentication.save!
    end
  end

end