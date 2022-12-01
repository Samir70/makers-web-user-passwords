require "user"
require "bcrypt"

class UserRepository
  def all
    sql = "SELECT * FROM users"
    return DatabaseConnection.exec_params(sql, []).map { |el|
             User.new(el["id"].to_i, el["name"], el["email"], el["password"])
           }
  end

  def find(name)
    sql = "SELECT * FROM users WHERE name = $1"
    return DatabaseConnection.exec_params(sql, [name]).map { |el|
             User.new(el["id"].to_i, el["name"], el["email"], el["password"])
           }[0]
  end

  def add(name, email, password)
    pass_hash = BCrypt::Password.create(password)
    sql = "INSERT INTO users (name, email, password) VALUES ($1, $2, $3)"
    DatabaseConnection.exec_params(sql, [name, email, pass_hash])
    return nil
  end

  def check_password(name, submitted_password)
    user = find(name)
    if user.nil?
        return false
    end
    pass_hash = BCrypt::Password.new(user.password)
    return pass_hash == submitted_password
  end
end
