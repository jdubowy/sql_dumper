require "minitest/autorun"
require "sql_dumper"
require 'ostruct'

class DummyModel
  include SqlDumper
  attr_accessor :id, :c_int, :c_float, :c_str, :c_bool, :c_null

  def self.columns
    [
      OpenStruct.new(name: "id"),
      OpenStruct.new(name: "c_int"),
      OpenStruct.new(name: "c_float"),
      OpenStruct.new(name: "c_str"),
      OpenStruct.new(name: "c_bool"),
      OpenStruct.new(name: "c_null")
    ]
  end

  def self.table_name
    "foo_bars"
  end

  def initialize
    @id = 1
    @c_int = 123
    @c_float = 234.234
    @c_str = "SDF"
    @c_bool = true
    @c_null = nil
  end
end

describe :SqlDumper do
  before do
    @object = DummyModel.new
  end

  describe "when asked to dump with no exclusions" do
    it "returns insert with all columns" do
      expected = "INSERT INTO foo_bars SET `id`=1, `c_int`=123, `c_float`=234.234, `c_str`='SDF', `c_bool`=1, `c_null`=NULL;"
      assert_equal expected, @object.to_sql
    end
  end

  describe "when asked to dump with exclusions" do
    it "returns insert lacking exclusions" do
      expected = "INSERT INTO foo_bars SET `c_int`=123, `c_str`='SDF', `c_bool`=1, `c_null`=NULL;"
      assert_equal expected, @object.to_sql(excluded_columns: [:id, :c_float])
    end
  end
end