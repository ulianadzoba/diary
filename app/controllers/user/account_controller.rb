class User::AccountController < ApplicationController
  before_action :authenticate_user!
end
