require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #show" do
    before(:each) do
      DatabaseCleaner.clean_with(:deletion)
      @valid_user = User.create!(
        email: "web@dev.dev",
        password: "password",
        gitHubUsername: "WebDeveloper",
        linkedInUrl: "https://www.linkedin.com/in/WebDeveloper"
      )
    end

    it "returns successfully with valid input" do
      get :show, params: {id: @valid_user.id}
      returned_json = JSON.parse(response.body)
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json).to_not be_kind_of(Array)
      expect(returned_json.length).to be(11)
      expect(returned_json["id"]).to eq(@valid_user.id)
      expect(returned_json["email"]).to be(nil)
      expect(returned_json["gitHubUsername"]).to eq(@valid_user.gitHubUsername)
      expect(returned_json["linkedInUrl"]).to eq(@valid_user.linkedInUrl)
    end

    it "returns empty array with invalid input" do
      get :show, params: {id: 1000000000}
      returned_json = JSON.parse(response.body)
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
      expect(returned_json).to be_kind_of(Array)
      expect(returned_json.length).to be(0)
    end
  end

  describe "GET #index" do
    before(:each) do
      DatabaseCleaner.clean_with(:deletion)
      @valid_user = User.create!(
        email: "web@dev.dev",
        password: "password",
        gitHubUsername: "WebDeveloper",
        linkedInUrl: "https://www.linkedin.com/in/WebDeveloper"
      )
      @valid_user2 = User.create!(
        email: "web2@dev.dev",
        password: "password2",
        gitHubUsername: "WebDeveloper2",
        linkedInUrl: "https://www.linkedin.com/in/WebDeveloper2"
      )
    end

    it "returns an array of all users" do
      get :index
      returned_json = JSON.parse(response.body)
      expect(response.content_type).to eq("application/json")
      expect(response.status).to eq(200)
      expect(returned_json).to_not be_kind_of(Hash)
      expect(returned_json).to be_kind_of(Array)
      expect(returned_json.length).to eq(2)
      expect(returned_json[0]["id"]).to eq(@valid_user.id)
      expect(returned_json[0]["email"]).to be(nil)
      expect(returned_json[0]["gitHubUsername"]).to eq(@valid_user.gitHubUsername)
      expect(returned_json[0]["linkedInUrl"]).to eq(@valid_user.linkedInUrl)
      expect(returned_json[1]["id"]).to eq(@valid_user2.id)
      expect(returned_json[1]["email"]).to be(nil)
      expect(returned_json[1]["gitHubUsername"]).to eq(@valid_user2.gitHubUsername)
      expect(returned_json[1]["linkedInUrl"]).to eq(@valid_user2.linkedInUrl)
    end
  end
end
