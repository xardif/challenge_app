class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def list
  	@users = User.all
  	@users = @users.sort_by &:points
  	@users.reverse!
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
