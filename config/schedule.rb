set :output, "#{path}/log/cron_log.log"

every "59 23 31 1,3,5,7,8,10,12 *" do
  rake "admin:clear_request_approved"
end

every "59 23 30 4,6,9,11 *" do
  rake "admin:clear_request_approved"
end

every "59 23 28 2 *" do
  rake "admin:clear_request_approved"
end
