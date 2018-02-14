describe "the get user info process", :type => :feature do
    before :all do
        @user = User.new(:login => "random_guy", :name => "Name", :avatar_url => "https://avatars2.githubusercontent.com/u/12294525", :followers => 1,  :public_repos => 9, :repos_url => "https://api.github.com/users/random_guy/repos")
        @user.save

        @user_not_populated = User.new(:login => "rand")
        @user_not_populated.save
    end

    ## Gives info  
    it "gives me info about a new user" do
        visit '/'
        within("form") do
            fill_in 'user[username]', with: 'uppe-r'
        end
        click_button 'Get Info'
        expect(page).to have_content 'https://api.github.com/users/uppe-r/repos'
    end

    it "gives me info when the form is submitted for an already existing user record" do
        visit '/'
        within("form") do
            fill_in 'user[username]', with: 'random_guy'
        end
        click_button 'Get Info'
        expect(page).to have_current_path('/users/random_guy')
        expect(page).to have_content 'https://api.github.com/users/random_guy/repos'
    end

    it "gives me info when an url for an already existing user record is visited" do
        visit '/users/random_guy'
        expect(page).to have_content 'random_guy'
    end

    ## Returns 404
    it "returns 404 when an url for a non-existant user record is visited" do
        visit '/users/randomuser'
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

    it "returns \"Not available yet\" when the user record is not populated" do
        visit '/users/rand'
        expect(page).to have_content 'Not available yet'
    end
 end