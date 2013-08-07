require 'redmine'

require_dependency 'issues_status_hook'

Redmine::Plugin.register :status_button do
  name 'Redmine Status Button plugin'
  author 'Zhang Fan'
  description 'Change the issues status by just one click.'
  version '0.0.1'
  url 'http://web.4399.com'
  author_url 'mailto:zhangfan@4399.net'
  requires_redmine :version_or_higher => '2.3.0'
  settings :default => {
    :status_assigned_to              => {}
  }, :partial => 'settings/status_button_settings'
end

module StatusButton
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => 'issues/status_button'
  end
end
