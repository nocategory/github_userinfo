# GitHub User Info
[![Build Status](https://travis-ci.com/uppe-r/github_userinfo.svg?token=iy8cDzpCgypSkJPdoxMC&branch=master)](https://travis-ci.com/uppe-r/github_userinfo)

A small and simple app powered by **Ruby on Rails** that fetches data from the GitHub API v3.

## System dependencies

 - Docker & [Compose](https://docs.docker.com/compose/install/)

## Quick start

 1. Clone the repository
 2. Run `docker-compose build`
 3. Run `docker-compose up`
 4. In another terminal window, run `docker-compose run web rake db:create && docker-compose run web rails db:migrate`
 5. Open [http://localhost:8080](http://localhost:8080) and the app should be running!

## Final notes

 - In case you have problems with [GitHub's API rate limiting](https://developer.github.com/v3/rate_limit/), set an environment variable called "**GH**" with a valid **OAuth2 token**
 - To run tests run `rspec` on the root folder, you might need to run `rails db:migrate RAILS_ENV=test` before
