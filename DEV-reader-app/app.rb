require_relative 'router.rb'
require_relative 'library.rb'
require_relative 'controller.rb'

csv_file = File.join(__dir__, 'posts.csv')
library = Library.new(csv_file)
controller = Controller.new(library)

router = Router.new(controller)
router.run
