require 'csv'

class ImportContactsFromFile

  def self.init(file, valid_columns: nil)
    csv_data = CSV.parse(file.download, headers: true)
    success = true
    
    csv_data.each do |contact_information|
      file.record.update(status: 'processing', information: 'still processing') unless file.record.processing?
      
      contact = Contact.new
      date_of_birth = Date.parse(contact_information['Date of Birth'].try(:strip)) rescue nil
      contact.name = contact_information['Name'].try(:strip)
      contact.address = contact_information['Address'].try(:strip)
      contact.email = contact_information['Email'].try(:strip)
      contact.credit_card = contact_information['CreditCard'].try(:strip)
      contact.phone = contact_information['Phone'].try(:strip)
      contact.date_of_birth = date_of_birth

      unless contact.save
        file.record.update(status: 'failed', information: "#{contact.email} #{contact.errors.messages}")
        success = false
        break
      end
    end

    file.record.update(status: 'terminated', information: 'File processed successfully') if success
  end

end