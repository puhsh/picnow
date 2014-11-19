namespace :groups do
  task :popluate_events => :environment do
    Event.delete_all
    Group.find_each do |group|
      activity = (group.group_photos + group.comments).sort_by(&:created_at)
      activity.each(&:record_event)
    end
  end
end
