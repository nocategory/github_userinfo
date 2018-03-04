require 'spec_helper'
require 'uri'
require 'faker'

describe "the get user info process", :type => :feature do
    before :all do
        stub_request(:get, /api.github.com/).
            to_return {
                |request| { 
                    status: 200,
                    body: {
                    "login": request.uri.path.slice("/users/"),
                    "avatar_url": "https://avatars2.githubusercontent.com/u/#{Faker::Number.number(8)}?v=4",
                    "repos_url": "https://api.github.com#{request.uri.path}/repos",
                    "name": Faker::Name.name,
                    "public_repos": Faker::Number.number(3),
                    "followers": Faker::Number.number(2),
                    }.to_json
                }
            }
    end
    ## Only the '-' character is allowed, as per Github rules
    random_username = Faker::Internet.user_name(nil, %w(-))

    ## Gives info  
    it "gives me info about a new user" do
        visit "/"
        within("form") do
            fill_in "user[username]", with: random_username
        end
        click_button 'Get Info'
        expect(page).to have_content "https://api.github.com/users/#{random_username}/repos"
    end

    it "gives me info when the form is submitted for an already existing user record" do
        visit '/'
        within("form") do
            fill_in "user[username]", with: random_username
        end
        click_button 'Get Info'
        expect(page).to have_current_path("/users/#{random_username}")
        expect(page).to have_content "https://api.github.com/users/#{random_username}/repos"
    end

    it "gives me info when an url for an already existing user record is visited" do
        visit "/users/#{random_username}"
        expect(page).to have_content random_username
    end

    ## Returns 404
    it "returns 404 when an url for a non-existant user record is visited" do
        visit "/users/#{Faker::Internet.user_name}"
        expect(page.status_code).to eq(404)
    end

    another_random_username = Faker::Internet.user_name(nil, %w(-))

    # Not available yet
    # to simulate a page visit on a record that is still being populated by a job
    it "returns \"Not available yet\" when the user record is not populated" do
        @user_not_populated = User.new(:login => another_random_username)
        @user_not_populated.save
        visit "/users/#{another_random_username}"
        expect(page).to have_content 'Not available yet'
    end
 end