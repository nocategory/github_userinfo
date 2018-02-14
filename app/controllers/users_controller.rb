require 'rest-client'

class UsersController < ApplicationController
    def create
        username = params[:user][:username]
        if User.exists?(:login => username)
            redirect_to '/users/' << username
            return
        end

        @user = User.new(:login => username)
        @user.save

        QueryapiJob.new.perform(@user)
        redirect_to '/users/' << @user.login
    end

    def show
        # params[:id] is actually the login nickname
        @user = User.find_by_login(params[:id]) or render file: "#{Rails.root}/public/404", status: 404
        if !@user.public_repos
            render file: "#{Rails.root}/public/not_available", status: 200
        end
    end
end