require "sql_dumper/version"

module SqlDumper
  def to_sql options={}
    excluded_columns = options[:excluded_columns] || []
    column_names = self.class.columns.map{ |c| c.name.to_sym }
    set_str = column_names.reject{ |n| excluded_columns.include?(n) }.map { |k|
      # TODO:  try to grab raw values from db (if persisted, or even if not if
      # active record somehow supports giving raw db vaues)
      v = send(k)
      if v.is_a?(String)
        v = "'#{v}'"
      elsif v == nil
        v = "NULL"
      elsif v.is_a?(TrueClass)
        v = 1
      elsif v.is_a?(FalseClass)
        v = 0
      elsif v.is_a?(Date)
        v = v.strftime("'%Y-%m-%d'")
      elsif v.respond_to?(:strftime)
        # TODO: make sure it's UTC...
        v = v.utc if v.respond_to?(:utc)
        v = v.strftime("'%Y-%m-%d %H:%M:%S'")
      end
      "`#{k}`=#{v}"
    }.join(', ')
    "INSERT INTO #{self.class.table_name} SET #{set_str};"
  end
end
