# yazi 'y' shortcut and cd into current directory after quitting
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

$env.config.buffer_editor = "cursor"

use std "path add"

if ($nu.os-info.name) == "macos" {
	path add "/opt/homebrew/bin"
	path add "/usr/local/bin"
}
