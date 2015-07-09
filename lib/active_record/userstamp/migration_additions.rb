module ActiveRecord::Userstamp::MigrationHelper
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def userstamps(include_deleted_by = false, *args)
      column(ActiveRecord::Userstamp.compatibility_mode ? :created_by : :creator_id, :integer, *args)
      column(ActiveRecord::Userstamp.compatibility_mode ? :updated_by : :updater_id, :integer, *args)
      column(ActiveRecord::Userstamp.compatibility_mode ? :deleted_by : :deleter_id, :integer, *args) if include_deleted_by
    end
  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include,
  ActiveRecord::Userstamp::MigrationHelper)