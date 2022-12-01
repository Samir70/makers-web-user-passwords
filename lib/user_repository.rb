require "user"

class UserRepository
  def all
    sql = "SELECT * FROM users"
    return DatabaseConnection.exec_params(sql, []).map { |el|
             User.new(el["name"], el["email"], el["password"])
           }
  end

  def find(name)
    sql = "SELECT * FROM users WHERE name = $1"
    return DatabaseConnection.exec_params(sql, [name]).map { |el|
             User.new(el["name"], el["email"], el["password"])
           }[0]
  end
end
