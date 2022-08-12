function config -wraps=/usr/bin/git
	/usr/bin/git --git-dir=/home/jacnil/.dotfiles/ --work-tree=/home/jacnil $argv
end
