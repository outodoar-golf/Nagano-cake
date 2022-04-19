class Admin::CustomerController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
     @customer = Customer.find(params[:id])
  end
  def update
      @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
       redirect_to admin_customer_path
     else
       render "edit"
     end
  end
  
   private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :telephone_number, :address)
  end
end
