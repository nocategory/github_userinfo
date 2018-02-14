class QueryapiJob
  include SuckerPunch::Job

  def perform(user)
    ## Build GitHub API url & auth header
    url = "https://api.github.com/users/" << user.login
    header = ENV["GH"] ? {:Authorization => 'token ' << ENV["GH"]} : {}

    ## Send the request and parse the response
    ## If there is a bad response from the API, return the 404 page and delete the user record
    begin
      response = RestClient.get url, header
      rescue RestClient::ExceptionWithResponse => err
        ApplicationController.render(
          file: "#{Rails.root}/public/404", status: 404
        )
        ## Deletes user record from database (only login attribute populated) 
        ## if the user does not exist in GitHub
        user.destroy!
        return err.response
    end
    data = JSON.parse(response.body, symbolize_keys: true)
    ## Create a new @user and save it
    user.update(:name => data['name'], :avatar_url => data['avatar_url'], :followers => data['followers'], :public_repos => data['public_repos'], :repos_url => data['repos_url'])
  end
end
