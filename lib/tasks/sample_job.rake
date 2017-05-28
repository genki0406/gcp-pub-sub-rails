desc 'issue job'
task issue_job: :environment do
  (1..5).each do |num|
    SampleJob.perform_later(num)
  end
end
