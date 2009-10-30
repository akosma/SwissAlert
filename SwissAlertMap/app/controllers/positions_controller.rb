require 'yaml'

class PositionsController < ApplicationController
  acts_as_iphone_controller

  def index
    if params.has_key?(:code)
      redirect_to show_url :code => params[:code]
    else
      @positions = Position.recent
      create_map_for_positions(@positions)
      # The center of Switzerland
      @map.center_zoom_init([46.751153, 8.245239], 8)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @positions }
        format.iphone
      end
    end
  end

  def show
    positions = []
    @position = Position.find(:first, :conditions => ["code = ?", params[:code]] )
    if @position
      positions = [@position]
    else
      positions = Position.recent
    end
    create_map_for_positions(positions)
    if @position
      @map.center_zoom_init([@position.latitude, @position.longitude], 12)
    else
      @map.center_zoom_init([46.751153, 8.245239], 8)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @position }
      format.iphone do
        env = ENV['RAILS_ENV'] || RAILS_ENV
        apikey = YAML.load_file(RAILS_ROOT + '/config/gmaps_api_key.yml')[env]
        coordinates = "#{@position.latitude},#{@position.longitude}"
        zoom = 12
        @image_tag = "<img alt=\"Google Maps image\" src=\"http://maps.google.com/maps/api/staticmap?center=#{coordinates}&zoom=#{zoom}&size=320x416&mobile=true&markers=color:red|label:#{@position.code.first}|#{coordinates}&sensor=false&key=#{apikey}\" width=\"320\" height=\"416\" />"
        @maps_url = "#{@position.code}@#{coordinates}&z=#{zoom}"
        render :layout => false
      end
    end
  end

  def create
    position = Position.new
    position.latitude = params[:latitude]
    position.longitude = params[:longitude]

    if position.save
      render :xml => position, :status => :created, :location => ""
    else
      render :xml => position.errors, :status => :unprocessable_entity
    end
  end
  
private

  def create_map_for_positions(positions)
    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)

    positions.each do |position|
      marker = GMarker.new([position.latitude, position.longitude], 
                            :title => "SwissAlert Info", 
                            :info_window => position.info_window)
      @map.overlay_init(marker)
    end
  end

end
