function make_status(newStatus) {
	if (typeof(jQuery) != 'undefined') {
		// redmine uses jQuery so use it.
		var $ = jQuery;
		var s = $('#issue_status_id');
		if (s.length === 0) {
			return;
		}
		var f = $('#issue-form');
		if (f.length === 0) {
			return;
		}
		s.val(newStatus);
		f.submit();
	} else {
		// redmine uses prototype so use it.
		var $ = document.getElementById;
		var s = $('issue_status_id');
		if (s === null) {
			return;
		}
		var f = $('issue-form');
		s.value = newStatus;
		f.submit();
	}
};

