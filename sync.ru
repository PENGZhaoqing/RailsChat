# Run with: rackup sync.ru -E production
# rackup sync.ru -E production -p 9292 --host 192.168.0.14
# rake tmp:clear

require "bundler/setup"
require "yaml"
require "faye"
require "render_sync"

Faye::WebSocket.load_adapter 'thin'

RenderSync.load_config(
  File.expand_path("../config/sync.yml", __FILE__),
  ENV["RAILS_ENV"] || "development"
)

run RenderSync.pubsub_app
