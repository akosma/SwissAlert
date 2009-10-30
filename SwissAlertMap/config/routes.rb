ActionController::Routing::Routes.draw do |map|
  map.root :controller => "positions", :action => "index", :conditions => { :method => :get }
  map.create '', :controller => "positions", :action => "create", :conditions => { :method => :post }
  map.position ':code', :controller => "positions", :action => "show", :conditions => { :method => :get }
end
