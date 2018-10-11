class LogsController < ApplicationController
  MAX_READ = 1000

  include ActionController::Live

  def something
    logger.info "Stream start"
    file = LogFile.find_path("development.log").tail
    response.headers['Content-Type'] = 'text/event-stream'
    first_line = true
    file.interval = 5
    file.backward(25)
    file.tail do |l|
      if first_line
        first_line = false
        next
      end
      stream_line l
    end
  rescue IOError => e
    logger.info "Stream closed (IOError)"
  rescue ActionController::Live::ClientDisconnected
    logger.info "Client Disconnected"
  rescue Errno::ECONNRESET => e
    logger.info "Stream closed (Errno)"
  else
    logger.info "Stream closed (Normaly)"
  ensure
    logger.info
    file.close if file
    response.stream.close
  end

  def index
  end

  def home
  end

  protected

  def stream_line line
    unless line.blank? || line == "\n"
      response.stream.write "data: #{line.to_json}<br>"
    end
  end

end
