require 'yaml'
require 'ostruct'
module SquarePush
  conf = YAML.load_file(File.dirname(File.expand_path(__FILE__)) + "/config.yml") || {}
  Config = OpenStruct.new(conf)
end