require './config/environment.rb'

use Rack::MethodOverride
use LoanController
use EntityController
run ApplicationController
