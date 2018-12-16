Rails.application.routes.draw do
  # Routes for the Packing list resource:

  # CREATE
  get("/packing_lists/new", { :controller => "packing_lists", :action => "new_form" })
  post("/create_packing_list", { :controller => "packing_lists", :action => "create_row" })
   post("/create_item", { :controller => "packing_lists", :action => "create_item" })

  # READ
  get("/packing_lists", { :controller => "packing_lists", :action => "index" })
  get("/packing_lists/:id_to_display", { :controller => "packing_lists", :action => "show" })
 

  # UPDATE
  get("/packing_lists/:prefill_with_id/edit", { :controller => "packing_lists", :action => "edit_form" })
  post("/update_packing_list/:id_to_modify", { :controller => "packing_lists", :action => "update_row" })
get("/update_item/:prefill_with_id/edit", { :controller => "packing_lists", :action => "edit_item" })
post("/update_item/:id_to_modify", { :controller => "packing_lists", :action => "update_item" })
  # DELETE
  get("/delete_packing_list/:id_to_remove", { :controller => "packing_lists", :action => "destroy_row" })
 get("/delete_item/:id_to_remove", { :controller => "packing_lists", :action => "destroy_item" })
  #------------------------------

  # Routes for the Trip resource:

  # CREATE
  get("/trips/new", { :controller => "trips", :action => "new_form" })
  post("/create_trip", { :controller => "trips", :action => "create_row" })

  # READ
  get("/trips", { :controller => "trips", :action => "index" })
  get("/trips/:id_to_display", { :controller => "trips", :action => "show" })
   root "trips#index"

  # UPDATE
  get("/trips/:prefill_with_id/edit", { :controller => "trips", :action => "edit_form" })
  post("/update_trip/:id_to_modify", { :controller => "trips", :action => "update_row" })

  # DELETE
  get("/delete_trip/:id_to_remove", { :controller => "trips", :action => "destroy_row" })

  #------------------------------
  
  post("/create_check/:id_to_modify/edit", { :controller => "packing_lists", :action => "create_check" })
  post("/delete_check/:id_to_modify/edit", { :controller => "packing_lists", :action => "delete_check" })

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
