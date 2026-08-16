run_segment() {
	local count

	count=$(grep -c . /tmp/claude-approvals 2>/dev/null || echo 0)

	if [ -n "$count" ] && [ "$count" -gt 0 ]; then
		echo "⚡ $count"
	fi

	return 0
}
