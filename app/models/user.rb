class User < ApplicationRecord
    validates :login, :avatar_url, :followers, :public_repos, :repos_url, presence: true
end
