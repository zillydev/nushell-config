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

$env.config.buffer_editor = "zed"

use std "path add"

use "./git-completions.nu" *

if ($nu.os-info.name) == "macos" {
	path add "/opt/homebrew/bin"
	path add "/usr/local/bin"
	path add "~/google-cloud-sdk/bin"
	$env.JAVA_HOME = (/usr/libexec/java_home -v 21)
	$env.ANDROID_HOME = "~/Library/Android/sdk"
  path add ($env.ANDROID_HOME | path join "cmdline-tools/latest/bin")
  path add ($env.ANDROID_HOME | path join "platform-tools")
}

if not (which fnm | is-empty) {
  ^fnm env --json | from json | load-env

  $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join (if $nu.os-info.name == 'windows' {''} else {'bin'}))
  $env.config.hooks.env_change.PWD = (
    $env.config.hooks.env_change.PWD? | append {
        condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|el| $el | path exists}}
        code: {|| ^fnm use --silent-if-unchanged}
    }
  )
}
