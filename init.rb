require 'redmine'

require_dependency 'time_tracker_hooks'

Redmine::Plugin.register :redmine_time_tracker do
    name 'Redmine Time Tracker plugin'
    author 'Jérémie Delaitre'
    description 'This is a plugin to track time in Redmine'
    version 'development'

    requires_redmine :version_or_higher => '0.9.0'

    settings :default => { 'refresh_rate' => '60' }, :partial => 'settings/time_tracker'

    menu :account_menu, :time_tracker_menu, '',
        {
            :caption => '',
            :html => { :id => 'time-tracker-menu' },
            :first => true,
            :param => :project_id,
            :if => Proc.new { User.current.logged? }
        }

    menu :top_menu, :time_tracker_admin_menu, { :controller => 'time_trackers', :action => 'index' },
        {
            :caption => :time_tracker_admin_menu,
            :if => Proc.new { User.current.admin }
        }
end

