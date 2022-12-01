require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "user is not logged in" do
    it "gives logged in status on root page" do
      response = get("/")
      expect(response.status).to eq 200
      expect(response.body).to include "You are not logged in"
      expect(response.body).to include '<a href="/login">Go to login page</a>'
    end
    it "shows user a login page" do
      response = get("/login")
      expect(response.status).to eq 200
      expect(response.body).to include '<form method="POST" action="/"'
      expect(response.body).to include '<input type="text" placeholder="username" name="name"'
      expect(response.body).to include '<input type="password" placeholder="password" name="password"'
      expect(response.body).to include '<input type="submit"'      
    end
    it "allows user to login with good creds" do
      response = post("/", name:"Sherlock", password:"TheButlerDidIt")
      expect(response.status).to eq 302
      response = follow_redirect!
      expect(last_request.get?).to eq true
      expect(response.body).to include "You are logged in, Sherlock"
    end
  end

  context "user is logged in" do
  end
end
