Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{REDIS_SERVER}:#{REDIS_SERVER_PORT}/12" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{REDIS_SERVER}:#{REDIS_SERVER_PORT}/12" }
end