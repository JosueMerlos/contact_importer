class ContactsController < ApplicationController
  def index
    @contacts = Contact.by_user(current_user.id)
  end
end
