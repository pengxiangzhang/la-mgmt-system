require 'singleton'

class ActionLogger < Logger
  include Singleton

  def initialize
    super(Rails.root.join('log/action_log.log'), 50, 1.megabyte)
    self.formatter = formatter()
    self
  end

  def formatter
    Proc.new { |severity, time, progname, msg|
      formatted_time = time.strftime('%Y-%m-%d %H:%M:%S')
      "[ACTION #{formatted_time} #{$$}] #{msg.to_s.strip}\n"
    }
  end

  class << self
    delegate :info, to: :instance
  end
end