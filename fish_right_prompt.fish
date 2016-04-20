set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_color_branch green
set __fish_git_prompt_color_dirtystate cyan
set __fish_git_prompt_color_untrackedfiles yellow

set __fish_git_prompt_char_cleanstate     '✔'
set __fish_git_prompt_char_dirtystate     '!'
set __fish_git_prompt_char_invalidstate   '#'
set __fish_git_prompt_char_stagedstate    '+'
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_untrackedfiles '…'

function git_pwd
	if git rev-parse --git-dir > /dev/null ^ /dev/null
		# we are inside a git directory, so use the name of the repo as the terminal title

		set -l git_dir (git rev-parse --git-dir)
		if test $git_dir = ".git"
			# we are at the root of the git repo
			echo (basename (pwd))
		else
			# we are at least one level deep in the git repo
			set -l repo_root (dirname (git rev-parse --git-dir))
			echo (pwd | sed 's@'(dirname $repo_root)'/@@')
		end
	else
		# we are NOT inside a git repo, so just use the working-directory
		echo (_prompt_pwd)
	end
end



function _prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
	if test "$PWD" != "$HOME"
		printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
else
	echo '~'
end
end


function fish_right_prompt
	printf '%s ' (__fish_git_prompt)
	set_color red
	printf '%s ' (git_pwd)
	set_color normal
end
