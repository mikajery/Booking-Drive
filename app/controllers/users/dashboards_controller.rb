class Users::DashboardsController < ApplicationController
  layout 'users/dashboards'
  def index
    @property = Property.new    
  end
end
