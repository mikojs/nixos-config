run_segment() {
	local count

	count=$(claude agents --json 2>/dev/null | jq '[.[] | select(.status == "waiting")] | length' 2>/dev/null || echo 0)

	if [ -n "$count" ] && [ "$count" -gt 0 ]; then
		echo "⚡ $count"
	fi

	return 0
}
