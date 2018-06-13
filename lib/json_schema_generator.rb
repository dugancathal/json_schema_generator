require "json_schema_generator/version"
require "json_schema_generator/generator"

module JsonSchemaGenerator
  def self.generate(json)
    Generator.new(json).schema
  end
end
