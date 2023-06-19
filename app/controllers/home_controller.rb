class HomeController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}
  def index
  end
end
