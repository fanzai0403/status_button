require 'redmine'

require_dependency 'issues_status_hook'

Redmine::Plugin.register :status_button do
  name 'Redmine Status Button plugin'
  author 'Zhang Fan'
  description 'Change the issues status by just one click.'
  version '0.1.0'
  url 'http://web.4399.com'
  author_url 'mailto:zhangfan@4399.net'
  requires_redmine :version_or_higher => '2.0.0'
  settings :default => {
    :status_assigned_to              => {},
    :check_all_status                => false,
    :add_watcher                     => true
  }, :partial => 'settings/status_button_settings'
end

module StatusButton
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => 'issues/status_button'
    
    def self.is_open?(project)
      print('===========>',project,"\n")
      field = project.custom_field_values.find{ |f| f.custom_field.name == 'status_button_plugin' }
      print('===========<',field.custom_field.name,"=",field.value=='1',"\n") if field
      return !field || field.value=='1'
	end
  end
end
