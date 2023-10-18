require_relative 'library'

def main
  app = LibraryApp.new
  app.run
  app.save_data 
end

main
