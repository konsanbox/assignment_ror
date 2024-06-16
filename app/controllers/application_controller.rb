class ApplicationController < ActionController::Base
  before_action :ensure_impersonate_as
  before_action :set_current_user

  private

  def ensure_impersonate_as
    return if cookies['impersonate_as']

    cookies['impersonate_as'] = User.first.id
  end

  def set_current_user
    @current_user = User.find(cookies['impersonate_as'])
  end
end
