namespace :admin do
  desc "TODO"
  task add_admin_account: :environment do
    create_admin_account
  end

  task clear_request_approved: :environment do
    clear_request_approved
  end

  def create_admin_account
    User.create!(name: "Admin",
                 email: "admin@mail.com",
                 password: "111111",
                 password_confirmation: "111111",
                 role: 0)
  end

  def clear_request_approved
    Request.approved.each do |request|
      puts "Request #{request.id}
        #{request.user.name} #{request.book.title} has been destroy"
        request.destroy
    end
  end
end
