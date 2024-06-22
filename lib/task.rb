module Task
  def self.run(task, &block)
    Rails.logger = ActiveSupport::Logger.new("log/task_#{task.name.gsub(':', '_')}.#{Rails.env}.log")
    Rails.logger.formatter = ::Logger::Formatter.new

    begin
      Rails.logger.info("Task #{task.name} started")
      block.call(task) if block_given?
      Rails.logger.info("Task #{task.name} ended")
    rescue => e
      Rails.logger.fatal("Task #{task.name} failed error:#{e.message}")
      Rails.logger.fatal(e.backtrace.join("\n"))
    end
  end
end
