
class IssueStatusHook < Redmine::Hook::ViewListener
	def controller_issues_new_before_save(context={})
		update_issues(context[:issue])
	end
	
	def controller_issues_edit_before_save(context={})
		return if !StatusButton::Hooks.is_open?(context[:issue].project)
		# TODO: 检测status变更（需要用到issues@attributes_before_change）
		update_issues(context[:issue])
	end
	
	def update_issues(issue)
		plugin = Redmine::Plugin.find(:status_button)
		setting = Setting["plugin_#{plugin.id}"] || plugin.settings['default']
		status_to_user = {}
		setting['status_assigned_to'].each { |s, a|
			unless a.blank?
				f = issue.custom_field_values.find { |f| f.custom_field_id == Integer(a) }
				status_to_user[Integer(s)] = Integer(f.value) if f && f.value && !f.value.empty?
			end }
		status_to_user
		issue.assigned_to_id = status_to_user[issue.status_id] if status_to_user[issue.status_id]
		issue.watcher_user_ids = issue.watcher_user_ids | status_to_user.map{|s,u| u} if setting['add_watcher']
	end
end
