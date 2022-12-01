require "user_repository"

def reset_users_table
  seed_sql = File.read("./spec/user_seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "users_test" })
  connection.exec(seed_sql)
end

RSpec.describe UserRepository do
  before(:each) do
    reset_users_table
  end

  it "lists all users" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq 3
    expect(users.first.class).to eq User
    expect(users.first.name).to eq "Sherlock"
    expect(users.last.name).to eq "Columbo"
    expect(users.last.id).to eq 3
  end
  it "finds user by name" do
    repo = UserRepository.new
    user = repo.find("Sherlock")
    expect(user.email).to eq "sholmes@bakerst.com"
    expect(user.name).to eq "Sherlock"
    expect(user.id).to eq 1
  end
  it "checks that passwords match" do
    repo = UserRepository.new
    does_match = repo.check_password("Sherlock", "TheButlerDidIt")
    does_not_match = repo.check_password("Sherlock", "WATSON!!!")
    expect(does_match).to eq true
    expect(does_not_match).to eq false
  end
  it "adds a user, with email and password details" do
    repo = UserRepository.new
    repo.add("Miss Marple", "achristie@orientexpress.com", "TheButlerDidIt")
    user = repo.find("Miss Marple")
    expect(user.email).to eq "achristie@orientexpress.com"
    expect(user.password).not_to eq "TheButlerDidIt"
    does_match = repo.check_password("Miss Marple", "TheButlerDidIt")
    does_not_match = repo.check_password("Miss Marple", "WATSON!!!")
    expect(does_match).to eq true
    expect(does_not_match).to eq false
  end
end
