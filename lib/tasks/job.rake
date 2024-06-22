namespace :holohato do
  namespace :job do
    desc "Generate job"
    task generate: :environment do |task|
      Task.run(task) do
        published_after = Date.today.prev_day(2)
        JobGenerator.generate(published_after:)
      end
    end
  end
end
