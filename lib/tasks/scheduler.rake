desc "This task is called by the Heroku scheduler add-on"
task :archive_jig_work_orders => :environment do
    puts "Archiving Jig Work Orders..."
    JigWorkOrder.archive_old_orders
    puts "done."
end

task :create_daily_jig_work_orders => :environment do 
  puts "Creating Daily Jig Work Orders..."
  JigWorkOrder.create_daily_jig_work_orders
  puts "done."
end
