require 'open-uri'
class TripsController < ApplicationController
  def index
    @trips = Trip.all.order('updated_at DESC') 
    
    render("trip_templates/index.html.erb")
  end

  def show
    @trip = Trip.find(params.fetch("id_to_display"))
    

     url_safe_street_address = URI.encode(@trip.destination)
     
      url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address + "&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
      parsed_data = JSON.parse(open(url).read)
      @latitude = parsed_data.dig("results", 0, "geometry", "location", "lat")
      @longitude = parsed_data.dig("results", 0, "geometry", "location", "lng")


    render("trip_templates/show.html.erb")
  end

  def new_form
    @trip = Trip.new

    render("trip_templates/new_form.html.erb")
  end

  def create_row
    @trip = Trip.new

    @trip.destination = params.fetch("destination")
    @trip.duration = params.fetch("duration")
    @trip.season = params.fetch("season")
    @trip.user_id = params.fetch("user_id")

    if @trip.valid?
      @trip.save
      
    # where algorithim starts  
      no_of_weeks= @trip.duration/7.to_i
      
     # SHORT SLEEVE SHIRTS
    
    if @trip.duration == 1 and @trip.season == "summer"
      short_sleeve_quantity = @trip.duration
      elsif @trip.season == "spring" and @trip.duration >1
      short_sleeve_quantity = (3/4 * @trip.duration).to_i
      elsif @trip.season == "fall" and @trip.duration > 1
      short_sleeve_quantity = (1/2 * @trip.duration).to_i
      elsif @trip.season == "spring" or @trip.season ==  "fall" and @trip.duration == 1
      short_sleeve_quantity = 1
    else
      short_sleeve_quantity = 0
    end
    
    
       @list = PackingList.new
      @list.item = "short sleeve tops"
      @list.quantity = short_sleeve_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
  
            
      
# LONG SLEEVE SHIRTS
    
    if @trip.duration == 1 and @trip.season == "fall" 
      long_sleeve_quantity = 1
      elsif@trip.season == "winter" and @trip.season == "fall" 
      long_sleeve_quantity = 1
      elsif @trip.season == "winter" and @trip.duration >1
      long_sleeve_quantity = (@trip.duration * 0.75).to_i
      elsif @trip.season == "fall" and @trip.duration > 1
      long_sleeve_quantity = (@trip.duration * 0.5).to_i
    else
      long_sleeve_quantity = 0
    end
    
    
       @list = PackingList.new
      @list.item = "long sleeve shirts"
      @list.quantity = long_sleeve_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
      
      #SWEATERS
      
      if @trip.season == "fall" and @trip.duration >= 7
	    sweater_quantity = no_of_weeks * 2
	    elsif @trip.season == "winter" and @trip.duration >= 7
	    sweater_quantity = no_of_weeks * 2
	    elsif @trip.season == "fall" and @trip.duration<7
	    sweater_quantity = 1
	    elsif @trip.season == "winter" and @trip.duration<7
	    sweater_quantity = 1
	    elsif @trip.season == "spring" and @trip.duration >=7
	    sweater_quantity = no_of_weeks
	    elsif @trip.season == "spring" and @trip.duration <7
	    sweater_quantity = 1
	    else 
      sweater_quantity = 0
      end

      @list = PackingList.new
      @list.item = "sweaters"
      @list.quantity = sweater_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
      
     # DRESS SHIRTS
     
    if @trip.duration == 1
    dress_shirt_quantity = 1
        elsif @trip.duration > 1 and @trip.duration < 7
        dress_shirt_quantity = 2
      elsif @trip.duration >= 7
      dress_shirt_quantity = no_of_weeks * 2
    else
      dress_shirt_quantity = 0
    end
      
       @list = PackingList.new
      @list.item = "dress shirts"
      @list.quantity = dress_shirt_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save


      
     #LIGHT JACKET
      
      if @trip.season == "summer" or @trip.season == "spring"
	    light_jacket_quantity = 1
      else 
      light_jacket_quantity = 0
      end
      @list = PackingList.new
      @list.item = "light jackets"
      @list.quantity = light_jacket_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
      #OUTERWEAR
      
      if @trip.season == "fall" or @trip.season == "winter"
	    outerwear_quantity = 1
      else 
      outerwear_quantity = 0
      end
      @list = PackingList.new
      @list.item = "outerwear"
      @list.quantity = outerwear_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
       
       
       #SHORTS
        if User.find(@trip.user_id).gender == "female" and @trip.season == "spring" 
        short_quantity = no_of_weeks  
         elsif User.find(@trip.user_id).gender == "female" and @trip.season == "fall"
        short_quantity = no_of_weeks 
	      elsif  User.find(@trip.user_id).gender == "female" and @trip.duration < 7  and @trip.season == "spring"
        short_quantity = 1
           elsif  User.find(@trip.user_id).gender == "female" and @trip.duration < 7  and @trip.season ==  "summer"
        short_quantity = 1
        elsif  User.find(@trip.user_id).gender == "female" and @trip.duration >= 7  and @trip.season == "spring" 
        short_quantity = no_of_weeks 
        elsif  User.find(@trip.user_id).gender == "female" and @trip.duration >= 7  and @trip.season ==  "summer"
        short_quantity = no_of_weeks 
        elsif  User.find(@trip.user_id).gender == "male" and @trip.duration >= 7  and @trip.season == "spring" 
        short_quantity = no_of_weeks *2
        elsif  User.find(@trip.user_id).gender == "male" and @trip.duration >= 7  and @trip.season == "summer" 
        short_quantity = no_of_weeks *3
        elsif  User.find(@trip.user_id).gender == "male" and @trip.duration < 7  and @trip.season == "summer"
        short_quantity = 1 
          elsif  User.find(@trip.user_id).gender == "male" and @trip.duration < 7  and @trip.season ==  "spring"
        short_quantity = 1 
        else
        short_quantity = 0
	      end

        @list = PackingList.new
        @list.item = "shorts"
        @list.quantity = short_quantity
        @list.trip_id = @trip.id
        @list.packed = false
        @list.save
        
        #SKIRTS
    
    if User.find(@trip.user_id).gender == "female" and @trip.season == "summer" 
    skirt_quantity = no_of_weeks  
        elsif User.find(@trip.user_id).gender == "female" and @trip.season ==  "spring" 
    skirt_quantity = no_of_weeks  
        elsif User.find(@trip.user_id).gender == "female" and @trip.season ==  "fall"
    skirt_quantity = no_of_weeks  
	  else 
    skirt_quantity = 0
	  end
				
        @list = PackingList.new
        @list.item = "skirt"
        @list.quantity = skirt_quantity
        @list.trip_id = @trip.id
        @list.packed = false
        @list.save
        
        #DRESSES  

        if User.find(@trip.user_id).gender == "female" and @trip.season == "spring" 
        dress_quantity = no_of_weeks  
        elsif User.find(@trip.user_id).gender == "female" and @trip.season ==  "fall"
        dress_quantity = no_of_weeks  
      	elsif  User.find(@trip.user_id).gender == "female" and @trip.duration < 7  and @trip.season == "summer"
        dress_quantity = 1
        elsif  User.find(@trip.user_id).gender == "female" and @trip.duration >= 7 and @trip.season == "summer"
        dress_quantity = no_of_weeks * 2
        else
        dress_quantity = 0
	      end

        @list = PackingList.new
        @list.item = "dress"
        @list.quantity = dress_quantity
        @list.trip_id = @trip.id
        @list.packed = false
        @list.save
        

      #JEANS
      
      if @trip.season == "winter" and @trip.duration >1
	    jean_quantity = @trip.duration/2.to_i
	    elsif @trip.season == "winter" and @trip.duration == 1
	    jean_quantity = 1
      elsif  User.find(@trip.user_id).gender == "male" and @trip.duration > 1  and @trip.season == "fall"
	    jean_quantity = @trip.duration/2.to_i
      elsif  User.find(@trip.user_id).gender == "male" and @trip.duration == 1  and @trip.season == "fall"
      jean_quantity = 1
      elsif User.find(@trip.user_id).gender == "female"  and @trip.season == "fall" and @trip.duration >=7
	    jean_quantity = no_of_weeks * 2
      elsif User.find(@trip.user_id).gender == "female" and @trip.season == "fall" and @trip.duration <7
	    jean_quantity = 1
      elsif @trip.season == "spring" and @trip.duration >=7
	    jean_quantity = no_of_weeks * 2
      elsif @trip.season == "spring" and @trip.duration <7
	    jean_quantity = 1
      elsif @trip.season == "summer" and @trip.duration >=7
	    jean_quantity = no_of_weeks 
      elsif @trip.season == "summer" and @trip.duration <7
	    jean_quantity = 1
	    else
	    jean_quantity = 0
      end

      @list = PackingList.new
      @list.item = "jeans"
      @list.quantity = jean_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
       #SWIMWEAR
      
      if @trip.season == "summer" and @trip.duration >= 7
	    swimwear_quantity = no_of_weeks * 2
	    elsif @trip.season == "summer" and @trip.duration < 7 and @trip.duration >3 
	    swimwear_quantity = 2
	    elsif @trip.season == "summer" and @trip.duration < 3 
	    swimwear_quantity = 1
	    elsif  @trip.season == "spring" and @trip.duration >= 7
	    swimwear_quantity = no_of_weeks
	    elsif @trip.season == "spring" and @trip.duration <7
	    swimwear_quantity = 1
	    else 
      swimwear_quantity = 0
      end
	
      @list = PackingList.new
      @list.item = "swimwear"
      @list.quantity = swimwear_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save

      #FLIPFLOPS
     
      if @trip.season == "spring" 
	    sandals_quantity = 1
	     elsif @trip.season == "summer"
	    sandals_quantity = 1
	    else
	    sandals_quantity = 0 
	    end
	
      @list = PackingList.new
      @list.item = "flip flops"
      @list.quantity = sandals_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
      #WALKING SHOES
      
      @list = PackingList.new
      @list.item = "walking shoes"
      @list.quantity = 1
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
      # DRESS SHOES
      
      @list = PackingList.new
      @list.item = "dress shoes"
      @list.quantity = 1
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save

      
      
     
     #SLEEPWEAR
      
      @list = PackingList.new
      @list.item = "sleepwear"
      @list.quantity = 1
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save 
      
      #BRAS
      
    if User.find(@trip.user_id).gender == "female" and @trip.duration >= 7
    		bra_quantity = 3 
    elsif User.find(@trip.user_id).gender == "female" and @trip.duration < 3
    		bra_quantity = 1
    elsif User.find(@trip.user_id).gender == "female" and @trip.duration >3 and @trip.duration <7 
    		bra_quantity = 2
    else 
    		  bra_quantity = 0
    end
				
        @list = PackingList.new
        @list.item = "bra"
        @list.quantity = bra_quantity
        @list.trip_id = @trip.id
        @list.packed = "false"
        @list.save
        
        #UNDERWEAR
        
      	if @trip.season == "spring" 
	      underwear_quantity = @trip.duration + no_of_weeks 
	      elsif @trip.season == "summer"
	      underwear_quantity == @trip.duration + no_of_weeks * 2
	      else 
        underwear_quantity = @trip.duration
        end
        
        @list = PackingList.new
        @list.item = "underwear"
        @list.quantity = @trip.duration
        @list.trip_id = @trip.id
        @list.packed = false
        @list.save
        
        
        #SOCKS
      
      if @trip.season == "winter" 
	    sock_quantity = @trip.duration
	     elsif @trip.season ==  "fall"
	    sock_quantity = @trip.duration
      elsif @trip.season == "spring" and @trip.duration > 1
	     sock_quantity = @trip.duration/2.to_i
	    elsif @trip.season == "spring" and @trip.duration == 1
	    sock_quantity = 1
	    elsif  @trip.season == "summer" and @trip.duration < 7
	    sock_quantity = 1
	    elsif @trip.season == "summer" and @trip.duration >= 7
	    sock_quantity = no_of_weeks * 2
	    else 
      sock_quantity = 0
      end

      @list = PackingList.new
      @list.item = "socks"
      @list.quantity = sock_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save

    
        
     
      
      
     
      
        
        

   

  
        
      @packing_list = PackingList.all
      
      redirect_to("/trips/#{@trip.id}", :notice => "Trip created successfully.")

      
       else
      render("trip_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @trip = Trip.find(params.fetch("prefill_with_id"))

    render("trip_templates/edit_form.html.erb")
  end

  def update_row
    @trip = Trip.find(params.fetch("id_to_modify"))

    @trip.destination = params.fetch("destination").titlecase
    @trip.duration = params.fetch("duration")
    @trip.season = params.fetch("season")
    @trip.user_id = params.fetch("user_id")

    if @trip.valid?
      @trip.save
      
      PackingList.where(trip_id: @trip.id).each do |trip| %
	
        #SWIMWEAR
      
      if trip.season == "summer" and trip.duration >= 7
	    swimwear_quantity = no_of_weeks * 2
	    elsif trip.season == "summer" and trip.duration < 7 and trip.duration >3 
	    swimwear_quantity = 2
	    elsif trip.season == "summer" and trip.duration < 3 
	    swimwear_quantity = 1
	    elsif  trip.season == "spring" and trip.duration >= 7
	    swimwear_quantity = no_of_weeks
	    elsif trip.season == "spring" and trip.duration <7
	    swimwear_quantity = 1
	    else 
      swimwear_quantity = 0
      end
	
      @list = PackingList.new
      @list.item = "swimwear"
      @list.quantity = swimwear_quantity
      @list.trip_id = @trip.id
      @list.packed = false
      @list.save
      
      

      redirect_to("/trips/#{@trip.id}", :notice => "Trip updated successfully.")
    else
      render("trip_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @trip = Trip.find(params.fetch("id_to_remove"))

    @trip.destroy

    redirect_to("/trips", :notice => "Trip deleted successfully.")
  end
  
  
  end
