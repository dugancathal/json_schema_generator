RSpec.describe JsonSchemaGenerator do
  let(:gen) {JsonSchemaGenerator}
  it "can identify top-level objects" do
    schema = gen.generate("{}")

    expect(schema).to eq "type": "object", properties: {}, "examples": [{}]
  end

  it "can identify top-level arrays" do
    schema = gen.generate("[]")

    expect(schema).to eq "type": "array", "items": {}
  end

  it "returns types (and examples) for properties on top-level objects" do
    schema = gen.generate('{"a": 1}')

    expect(schema).to eq(
      "type": "object",
      "examples": [{"a": 1}],
      "properties": {
        "a": {"type": "number", examples: [1]},
      },
    )
  end

  it 'returns types for values inside top-level arrays' do
    schema = gen.generate('["2"]')

    expect(schema).to eq(
      "type": "array",
      "items": {
        "type": "string",
        "examples": ["2"]
      }
    )
  end

  it 'recursively generates schemas for nested objects' do
    schema = gen.generate('{"a": {"b": 1}}')

    expect(schema).to eq(
      "type": "object",
      "examples": [{"a": {"b": 1}}],
      "properties": {
        "a": {
          "type": "object",
          "examples": [{"b": 1}],
          "properties": {
            "b": {
              "type": "number",
              "examples": [1]
            }
          }
        }
      }
    )
  end

  it 'knows about boolean types' do
    schema = gen.generate('{"a": false}')

    expect(schema).to eq(
      "type": "object",
      "examples": [{"a": false}],
      "properties": {"a": {"type": "boolean", "examples": [false]}},
    )
  end

  it 'works for really big json' do
    schema = gen.generate(<<-JSON)
      {
        "checked": false,
        "dimensions": {
          "width": 5,
          "height": 10
        },
        "id": 1,
        "name": "A green door",
        "price": 12.5,
        "tags": [
          "home",
          "green"
        ]
      }
    JSON

    expect(schema).to eq(
      "type": "object",
      "examples": [{"checked": false, "dimensions": {"width": 5, "height": 10}, "id": 1, "name": "A green door", "price": 12.5, "tags": ["home", "green"]}],
      "properties": {
        "checked": {
          "type": "boolean",
          "examples": [false]
        },
        "dimensions": {
          "type": "object",
          "examples": [{"width": 5, "height": 10}],
          "properties": {
            "width": {
              "type": "number",
              "examples": [5]
            },
            "height": {
              "type": "number",
              "examples": [10]
            }
          }
        },
        "id": {
          "type": "number",
          "examples": [1]
        },
        "name": {
          "type": "string",
          "examples": ["A green door"]
        },
        "price": {
          "type": "number",
          "examples": [12.5]
        },
        "tags": {
          "type": "array",
          "items": {
            "type": "string",
            "examples": ["home"]
          }
        }
      }
    )
  end
end
