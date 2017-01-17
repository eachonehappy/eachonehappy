class ContactsController < ApplicationController
 
  def index
    @contacts = Contact.all.sort_by(&:created_at).reverse
  end
  
  def new
    @contact = Contact.new
  end
  
  def create
  	@contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Thanku For Your Valuable Suggestion"
      redirect_to request.referer
    else
      render 'new'
    end
  end
 
  def destroy
    Contact.find(params[:id]).destroy
    flash[:success] = "Contact deleted"
    redirect_to request.referer
  end
  
  private
    
    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message)
    end

end
