require "sql_dumper/version"

module SqlDumper
  def to_sql options={}
    excluded_columns = options[:excluded_columns] || []
    column_names = self.class.columns.map{ |c| c.name.to_sym }
    set_str = column_names.reject{ |n| excluded_columns.include?(n) }.map { |k|
      v = send(k)
      if v.is_a?(String)
        v = "'#{v}'"
      elsif v == nil
        v = "NULL"
      elsif v.is_a?(TrueClass)
        v = 1
      elsif v.is_a?(FalseClass)
        v = 0
      end
      "`#{k}`=#{v}"
    }.join(', ')
    "INSERT INTO #{self.class.table_name} SET #{set_str};"
  end
end
