class ParkingsController < InheritedResources::Base
  defaults    :resource_class => Drive, :collection_name => 'parkings', :instance_name => 'parking'
  actions :index
  layout 'frontend'

  def country
    puts params
  end

  def state
    puts params
  end

  def city
    puts params
  end
end
