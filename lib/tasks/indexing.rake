namespace :holohato do
  namespace :indexing do
    desc "Indexing live chat message"
    task live_chat_message: :environment do |task|
      Task.run(task) do
        job = Job.where(state: :waiting).order(:id).first
        if job.nil?
          job = Job.where(state: [:in_process, :failed])
            .where('retry_count <= ?', Job::RETRY_LIMIT)
            .where('updated_at <= ?', 12.hours.ago)
            .first
        end
        next if job.nil?

        job.update!(state: :in_process)
        video = Video.find_by(video_id: job.video_id)

        begin
          Rails.logger.info("started indexing live chat messages. video_id:#{job.video_id}")
          job.state = Indexer.indexing_live_chat_messages(video)
          Rails.logger.info("indexing live chat messages #{job.state}. video_id:#{job.video_id}")
        rescue => e
          Rails.logger.error("failed job. video_id:#{job.video_id} error:#{e.message}")
          Rails.logger.error(e.backtrace.join("\n"))

          job.state = :failed
          job.retry_count += 1
          if job.retry_count > Job::RETRY_LIMIT
            if e.is_a?(Indexer::LiveChatNotFoundError)
              Rails.logger.info "Skipping indexing because live chat data file does not exist. video_id:#{job.video_id}"
              job.state = :skip
            else
              Rails.logger.fatal "exceeded retry limit. video_id:#{job.video_id}"
            end
          end
        end
        job.save!
      end
    end
  end
end
