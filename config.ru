require './config/environment.rb'

use Rack::MethodOverride
use LoanController
run ApplicationController
