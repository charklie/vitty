module main

import os
import info

struct Config {
	ascii_override ?string
	single_info    ?string
	custom_config  ?string
	ignore_config  bool
}

fn Config.new(ascii_override ?string, single_info ?string, custom_config ?string, ignore_config bool) Config {
	return Config{ascii_override, single_info, custom_config, ignore_config}
}

fn help() {}

fn parse_args() Config {
	mut ascii_override := ?string(none)
	mut single_info := ?string(none)
	mut custom_config := ?string(none)
	mut ignore_config := false

	for idx, item in os.args {
		


		if item.starts_with('-') {
			match item {
				'--help', '--usage', '-h' {
					help()
				}
				'--override', '-o' {
					ascii_override = if !os.args[idx + 1].starts_with('-') {
						os.args[idx + 1]
					} else {
						panic("Couldn't get override, check usage of `--override` with the `--help` flag.")
					}
				}
				'--info', '-i' {
					single_info = if !os.args[idx + 1].starts_with('-') {
						os.args[idx + 1]
					} else {
						panic("Couldn't get the info wanted, check usage of `--info` with the `--help` flag.")
					}
				}
				'--config', '-c' {
					custom_config = if !os.args[idx + 1].starts_with('-') {
						os.args[idx + 1]
					} else {
						panic("Couldn't get custom config path, check usage of `--config` with the `--help` flag.")
					}
				}
				'--ignore-config' {
					ignore_config = true
				}
				else {}
			}
		}
	}

	return Config.new(ascii_override, single_info, custom_config, ignore_config)
}

fn main() {
	println(info.windows_package_managers())
	println(info.uptime())
}
