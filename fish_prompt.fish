function fish_prompt
	set -l last_status $status
	if test -n "$SSH_CONNECTION"
		printf '%s ' $HOSTNAME
	end

	if not test $last_status -eq 0
		set_color red
		printf "⊥"
	else
		set_color blue
		printf "⊢"
	end
	set_color normal
	printf " "
end
