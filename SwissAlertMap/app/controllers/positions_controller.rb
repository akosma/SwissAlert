require 'yaml'

class PositionsController < ApplicationController
  acts_as_iphone_controller

  def index
    if params.has_key?(:code)
      redirect_to position_url :code => params[:code].upcase
      return 
    end

    @positions = Position.recent

    respond_to do |format|
      format.html do
        create_map_for_positions(@positions)
        # The center of Switzerland
        @map.center_zoom_init([46.751153, 8.245239], 8)
      end

      format.xml do
        render :xml => @positions 
      end

      format.js do
        render :json => @positions 
      end

      format.iphone
    end
  end
  
  def show
    @position = Position.find(:first, :conditions => ["code = ?", params[:code].upcase] )

    respond_to do |format|
      format.html do
        if @position
          @positions = [@position]
          create_map_for_positions(@positions)
          @map.center_zoom_init([@position.latitude, @position.longitude], 12)
        else
          @positions = Position.recent
          create_map_for_positions(@positions)
          @map.center_zoom_init([46.751153, 8.245239], 8)
        end
      end

      format.xml do
        if @position
          render :xml => @position 
        else
          render :xml => {"error" => "Not Found"}, :status => 404
        end
      end

      format.js do
        if @position
          render :json => @position 
        else
          render :json => {"error" => "Not Found"}, :status => 404
        end
      end

      format.iphone do
        if @position
          env = ENV['RAILS_ENV'] || RAILS_ENV
          apikey = YAML.load_file(RAILS_ROOT + '/config/gmaps_api_key.yml')[env]
          coordinates = "#{@position.latitude},#{@position.longitude}"
          zoom = 12
          @image_tag = "<img alt=\"Google Maps image\" src=\"http://maps.google.com/maps/api/staticmap?center=#{coordinates}&zoom=#{zoom}&size=320x416&mobile=true&markers=color:red|label:#{@position.code.first}|#{coordinates}&sensor=false&key=#{apikey}\" width=\"320\" height=\"416\" />"
          @maps_url = "#{@position.code}@#{coordinates}&z=#{zoom}"
        end
        render :layout => false
      end
    end
  end

  def create
    @position = Position.new
    @position.latitude = params[:latitude]
    @position.longitude = params[:longitude]

    respond_to do |format|
      format.html do
        if @position.save
          redirect_to position_url :code => @position.code
        else
          redirect_to root_url
        end
      end

      format.xml do
        if @position.save
          render :xml => @position, :status => :created, :location => "" 
        else
          render :xml => @position.errors, :status => :unprocessable_entity
        end
      end
      
      format.js do
        if @position.save
          render :json => @position, :status => :created, :location => "" 
        else
          render :json => @position.errors, :status => :unprocessable_entity
        end
      end
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
