
module Kemal
  def self.display_startup_message(config, server)
    addresses = server.addresses.map { |address| "#{config.scheme}://#{address}" }.join ", "
    log "[#{config.env}] Chiron is running at #{addresses}"
  end
end
