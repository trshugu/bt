Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
    puts "redisS OK"
end

Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
    puts "redisC OK"
end