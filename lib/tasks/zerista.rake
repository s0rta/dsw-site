namespace :zerista do
  task :sync_events => :environment do
    Submission.propagate_to_zerista
  end
end
