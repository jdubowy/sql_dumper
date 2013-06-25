require "minitest/autorun"
require "sql_dumper"
require "date"
require 'ostruct'

class DummyModel
  include SqlDumper
  attr_accessor :id, :c_int, :c_float, :c_str, :c_bool, :c_null, :c_date, :c_time

  def self.columns
    [
      OpenStruct.new(name: "id"),
      OpenStruct.new(name: "c_int"),
      OpenStruct.new(name: "c_float"),
      OpenStruct.new(name: "c_str"),
      OpenStruct.new(name: "c_bool"),
      OpenStruct.new(name: "c_null"),
      OpenStruct.new(name: "c_date"),
      OpenStruct.new(name: "c_time")
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
    @c_date = Date.new(2013, 1, 2)
    @c_time = Time.new(2014, 7, 23, 3, 43, 5, -3600)
  end
end

describe :SqlDumper do
  before do
    @object = DummyModel.new
  end

  describe "when asked to dump with no exclusions" do
    it "returns insert with all columns" do
      expected = "INSERT INTO foo_bars SET `id`=1, `c_int`=123, " +
        "`c_float`=234.234, `c_str`='SDF', `c_bool`=1, `c_null`=NULL, " +
        "`c_date`='2013-01-02', `c_time`='2014-07-23 04:43:05';"
      assert_equal expected, @object.to_sql
    end
  end

  describe "when asked to dump with exclusions" do
    it "returns insert lacking exclusions" do
      expected = "INSERT INTO foo_bars SET `c_int`=123, `c_str`='SDF', " +
      "`c_bool`=1, `c_null`=NULL, `c_date`='2013-01-02';"
      assert_equal expected, @object.to_sql(excluded_columns: [:id, :c_float, :c_time])
    end
  end
end