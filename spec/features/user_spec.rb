require 'faker'

describe "the get user info process", :type => :feature do
    random_username = Faker::Internet.user_name

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

    it "returns 404 when a non-existant GitHub user is submitted" do
        visit '/'
        within("form") do
            fill_in 'user[username]', with: 'randomusernamethatibetdoesnotexist31313221'
        end
        click_button 'Get Info'
        expect(page.status_code).to eq(404)
    end

    another_random_username = Faker::Internet.user_name
    # Not available yet
    # to simulate a page visit on a record that is still being populated by a job
    it "returns \"Not available yet\" when the user record is not populated" do
        @user_not_populated = User.new(:login => another_random_username)
        @user_not_populated.save
        visit "/users/#{another_random_username}"
        expect(page).to have_content 'Not available yet'
    end
 end