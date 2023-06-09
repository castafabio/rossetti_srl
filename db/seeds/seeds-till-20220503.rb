Role.create!(code: 'super_admin', name: 'Super Amministratore', value: 10)
Role.create!(code: 'admin', name: 'Amministratore', value: 20)
Role.create!(code: 'clerk', name: 'Amministrazione', value: 30)
Role.create!(code: 'production', name: 'Produzione', value: 40)
puts "Importing Users..."
# Users
json = ActiveSupport::JSON.decode(File.read('db/seeds/users.json'))
json.each do |environment, users|
  next if environment == 'development' && Rails.env != 'development'
  users.each do |user|
    usr = User.create!(user)
  end
end
puts "Users imported. "
