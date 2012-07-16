# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SquareOne::Application.initialize!

# Add Paperclip to path
#Paperclip.options[:command_path] = "/opt/local/bin/"