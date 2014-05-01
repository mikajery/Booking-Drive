class ParkingsController < InheritedResources::Base
  defaults    :resource_class => Drive, :collection_name => 'parkings', :instance_name => 'parking'
  actions :index
  layout 'frontend'
end
