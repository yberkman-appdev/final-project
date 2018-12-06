class PackingListsController < ApplicationController
  def index
    @packing_lists = PackingList.all

    render("packing_list_templates/index.html.erb")
  end

  def show
    @packing_list = PackingList.find(params.fetch("id_to_display"))

    render("packing_list_templates/show.html.erb")
  end

  def new_form
    @packing_list = PackingList.new

    render("packing_list_templates/new_form.html.erb")
  end

  def create_row
    @packing_list = PackingList.new

    @packing_list.item = params.fetch("item")
    @packing_list.quantity = params.fetch("quantity")
    @packing_list.trip_id = params.fetch("trip_id")

    if @packing_list.valid?
      @packing_list.save

      redirect_back(:fallback_location => "/packing_lists", :notice => "Packing list created successfully.")
    else
      render("packing_list_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @packing_list = PackingList.find(params.fetch("prefill_with_id"))

    render("packing_list_templates/edit_form.html.erb")
  end

  def update_row
    @packing_list = PackingList.find(params.fetch("id_to_modify"))

    @packing_list.item = params.fetch("item")
    @packing_list.quantity = params.fetch("quantity")
    @packing_list.trip_id = params.fetch("trip_id")

    if @packing_list.valid?
      @packing_list.save

      redirect_to("/packing_lists/#{@packing_list.id}", :notice => "Packing list updated successfully.")
    else
      render("packing_list_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @packing_list = PackingList.find(params.fetch("id_to_remove"))

    @packing_list.destroy

    redirect_to("/packing_lists", :notice => "Packing list deleted successfully.")
  end
  
   def create_item
     @trip = 
    @item = PackingList.new

    @item.item = params.fetch("item")
    @item.quantity = params.fetch("quantity")
    @item.trip_id = params.fetch("trip_id")

    if @item.valid?
      @item.save

     redirect_back(:fallback_location => "/trips/#{@trip.id}", :notice => "Item created successfully.")

    end
  end
  
  
end
