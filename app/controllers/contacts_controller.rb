require 'pry'
class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_any!

  def new
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.new(customer: @customer)
  end

  def create 
    @contact = Contact.new(contact_params)
    @customer = Customer.find(params[:customer_id])
    @contact.customer = @customer 
    if @contact.save
      redirect_to customer_contact_path(@customer, @contact), notice: "Contact successfully created."
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to customer_contact_path(@contact.customer, @contact), notice: "Contact successfully updated."
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @customer = @contact.customer
    @contact.destroy
    redirect_to customer_path(@customer), notice: "Contact was successfully destroyed."
  end

  def index
    @contacts = Contact.all
  end

  private 

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:customer_id, :first_name, :last_name, :email, :phone, :fax, :kind, :note)
    end
end
