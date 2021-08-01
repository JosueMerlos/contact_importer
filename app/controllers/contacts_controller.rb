class ContactsController < ApplicationController
  def index
    @contacts = Contact.by_user(current_user.id).page(params[:page])
  end
end
