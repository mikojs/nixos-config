run_segment() {
	local count

	count=$(wc -l < /tmp/claude-approvals 2>/dev/null | tr -d ' ')

	if [ -n "$count" ] && [ "$count" -gt 0 ]; then
		echo "⚡ $count"
	fi

	return 0
}
