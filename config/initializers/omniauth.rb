Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "254068608049050", "a5084cc119dd53403500431242f02a16", :strategy_class => OmniAuth::Strategies::Facebook, :display => 'popup', :scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_stream'
end