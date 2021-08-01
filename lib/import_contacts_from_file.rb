require 'csv'

class ImportContactsFromFile

  def self.init(file, valid_columns)
    csv_data = CSV.parse(file.download, headers: true)
    success = true
    
    csv_data.each do |contact_information|
      file.record.update(status: 'processing', information: 'still processing') unless file.record.processing?
      
      contact = Contact.new
      contact.user_id = file.record.user_id
      date_of_birth = Date.parse(contact_information[valid_columns['date'].to_i].try(:strip)) rescue nil
      contact.name = contact_information[valid_columns['name'].to_i].try(:strip)
      contact.address = contact_information[valid_columns['address'].to_i].try(:strip)
      contact.email = contact_information[valid_columns['email'].to_i].try(:strip)
      contact.credit_card = contact_information[valid_columns['credit_card'].to_i].try(:strip)
      contact.phone = contact_information[valid_columns['phone'].to_i].try(:strip)
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