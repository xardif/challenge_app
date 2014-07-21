class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def list
  	@users = User.order('points DESC')
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
