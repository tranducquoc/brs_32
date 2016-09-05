namespace :admin do
  desc "TODO"
  task add_admin_account: :environment do
    create_admin_account
  end

  def create_admin_account
    User.create!(name: "Admin",
                 email: "admin@mail.com",
                 password: "111111",
                 password_confirmation: "111111",
                 role: 0)
  end
end
