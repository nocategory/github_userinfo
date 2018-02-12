require 'rest-client'

class UsersController < ApplicationController
    def create
        ## Build GitHub API url & auth header
        url = "https://api.github.com/users/" << username
        header = ENV["GH"] ? {:Authorization => 'token ' << ENV["GH"]} : {}

        ## Send the request and parse the response
        response = RestClient.get url, header
        data = JSON.parse(response.body, symbolize_keys: true)

        ## Create a new @user and save it
        @user = User.new(:login => data['login'], :name => data['name'], :avatar_url => data['avatar_url'], :followers => data['followers'], :public_repos => data['public_repos'], :repos_url => data['repos_url'])
        @user.save

        redirect_to '/users/' << @user.login
    end
end