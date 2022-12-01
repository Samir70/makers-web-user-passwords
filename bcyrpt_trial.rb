require "bcrypt"

# make a new Password object
pass_hash = BCrypt::Password.create("hello world")
# save as a string
pass_hash_string = pass_hash.to_s
puts pass_hash, pass_hash.class
puts pass_hash_string, pass_hash_string.class

# turn the string you have into a new password object
pass_hash_reborn = BCrypt::Password.new(pass_hash_string)
# Compare to the password
puts pass_hash_reborn == "hello world" # expect true
puts pass_hash_reborn == "sdkjfahsk" # expect false


# I copied this hash from the terminal, but something is not being printed there
pretend_from_db = BCrypt::Password.new("$2a$12$QonFNjYZNPNQIuLZMNQoe.mG7a8uUd.nJMIApN0n9scoqqdX4P0hO")
puts "hello world" == pretend_from_db