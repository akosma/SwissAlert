class PositionsController < ApplicationController

  def index
    if params.has_key?(:code)
      redirect_to show_url :code => params[:code]
    else
      @positions = Position.recent
      create_map_for_positions(@positions)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @positions }
      end
    end
  end

  def show
    positions = []
    zoom = 8
    @position = Position.find(:first, :conditions => ["code = ?", params[:code]] )
    if @position
      positions = [@position]
      zoom = 12 
    else
      positions = Position.recent
    end
    create_map_for_positions(positions, zoom)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @position }
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

  def create_map_for_positions(positions, zoom = 8)
    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)

    if positions.count == 1
      @map.center_zoom_init([positions[0].latitude, positions[0].longitude], zoom)
    else
      # The center of Switzerland
      @map.center_zoom_init([46.751153, 8.245239], zoom)
    end

    positions.each do |position|
      marker = GMarker.new([position.latitude, position.longitude], 
                            :title => "SwissAlert Info", 
                            :info_window => position.info_window)
      @map.overlay_init(marker)
    end
  end

end
