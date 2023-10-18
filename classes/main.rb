require_relative 'library'

def main
  app = LibraryApp.new
  app.load_data
  app.run
end

main
