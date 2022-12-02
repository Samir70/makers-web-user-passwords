require "spec_helper"
require "rack/test"
require_relative "../../app"

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
      response = post("/", name: "Sherlock", password: "TheButlerDidIt")
      expect(response.status).to eq 302
      response = follow_redirect!
      expect(last_request.get?).to eq true
      expect(response.body).to include "You are logged in, Sherlock"
    end
    it "redirects to home login with bad creds" do
      response = post("/", name: "Sherlock", password: "WATSON!!!")
      expect(response.status).to eq 400
      expect(response.body).to include "You are not logged in"
    end
    it "redirects from accounts page to login page" do
      response = get("/accounts")
      expect(response.status).to eq 302
      follow_redirect!
      expect(last_request.get?).to eq true
      expect(last_request.url).to eq "http://example.org/login"
    end
  end

  context "user is logged in" do
    it "gives logged in status on root page" do
      response = post("/", name: "Sherlock", password: "TheButlerDidIt")
      # response = get("/")
      expect(response.status).to eq 302
      response = follow_redirect!
      expect(response.body).to include "You are logged in, Sherlock"
      expect(response.body).to include '<a href="/accounts">Go to accounts page</a>'
    end
    it "allows access to accounts page" do
      post("/", name: "Sherlock", password: "TheButlerDidIt")
      response = get("/accounts")
      expect(response.status).to eq 200
      expect(response.body).to include "You have 28p in your account, Sherlock"
    end
  end
end
