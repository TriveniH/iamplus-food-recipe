# Ruby
require 'benchmark'


# Gems
require 'sinatra'
require 'json'
require 'awesome_print'
require 'newrelic_rpm'
require 'oauth'
require 'httparty'
require 'redis'
require 'mongoid'
require 'zipkin-tracer'


# Helper
require './app/helpers'



# Modules
require_all :modules
require_all :bigOven



# Models
require_all :models


# App
require './app/api'


$stdout.sync = true

set :raise_errors, true
set :show_exceptions, false

Mongoid.load!( 'config/mongoid.yml', ENV[ 'RACK_ENV' ])
Mongo::Logger.logger.level = Logger::ERROR

zipkin_config = { service_name:ENV[ 'NEW_RELIC_APP_NAME' ],
                  service_port:settings.port,
                  sampled_as_boolean:false,
                  sample_rate: 1,
                  json_api_host: ENV[ 'ZIPKIN_JSON_API_HOST' ]}

use ZipkinTracer::RackHandler, zipkin_config