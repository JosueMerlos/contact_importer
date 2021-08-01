class ProcessFileWorker < ApplicationJob
  queue_as :default

  def perform(file, valid_columns)
    puts 'Processing File!!!'
    file = UserFile.find(file).file
    ImportContactsFromFile.init(file, valid_columns)
  end
 end
