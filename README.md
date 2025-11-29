# My nushell configuration

- Command for editing nushell config - `config nu`
- Pretty-print and page through the documentation for configuration options using - `config nu --doc | nu-highlight | less -R`

## Change the mac config path from ~/Application Support/nushell/config.nu to ~/.config/config.nu

- Create file at `~/Library/LaunchAgents/environment.plist` with the following content:

```xml
<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0">
<dict>
<key>Label</key><string>my.startup.shell_agnostic.environment</string>
<key>ProgramArguments</key><array><string>sh</string><string>-c</string><string>
  launchctl setenv XDG_CONFIG_HOME ~/.config
</string></array>
<key>RunAtLoad</key><true/>
</dict>
</plist>
```

- Then restart the device
- Ref - https://github.com/nushell/nushell/discussions/5279
