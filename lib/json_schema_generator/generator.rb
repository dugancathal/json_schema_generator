require 'json'

module JsonSchemaGenerator
  class Generator
    attr_reader :json

    def initialize(json)
      @json = json
    end

    def schema
      schema_of(JSON.parse(json, symbolize_names: true))
    end

    private

    def object_schema(obj)
      property_schemas = obj.keys.each_with_object({}) do |key, h|
        h[key.to_sym] = schema_of(obj[key])
      end
      {type: 'object', properties: property_schemas, examples: [obj]}
    end

    def array_schema(arr)
      items_schema = arr.first ? {type: type_of(arr.first), examples: [arr.first]} : {}
      {type: 'array', items: items_schema}
    end

    def schema_of(val)
      case val
      when Array then array_schema(val)
      when Hash then object_schema(val)
      else
        {type: type_of(val), examples: [val]}
      end
    end

    def type_of(val)
      case val
      when TrueClass, FalseClass then 'boolean'
      when String then 'string'
      when Array then 'array'
      when Numeric then 'number'
      else
        'object'
      end
    end
  end
end