module main

import os

struct Config {
	overriden_ascii ?string
	single_info     ?string
	custom_config   ?string
	ignore_config   bool
}

fn help() {}

fn parse_args() Config {
	mut overriden_ascii_ := ?string(none)
	mut single_info_ := ?string(none)
	mut custom_config_ := ?string(none)
	mut ignore_config_ := false

	for idx, item in os.args {
		if item.starts_with('-') {
			match item {
				'--help', '--usage', '-h' {
					help()
				}
				'--override', '-o' {
					overriden_ascii_ = if !os.args[idx + 1].starts_with('-') {
						os.args[idx + 1]
					} else {
						panic("Couldn't get override, check usage of `--override` with the `--help` flag.")
					}
				}
				'--info', '-i' {
					single_info_ = if !os.args[idx + 1].starts_with('-') {
						os.args[idx + 1]
					} else {
						panic("Couldn't get the info wanted, check usage of `--info` with the `--help` flag.")
					}
				}
				'--config', '-c' {
					custom_config_ = if !os.args[idx + 1].starts_with('-') {
						os.args[idx + 1]
					} else {
						panic("Couldn't get custom config path, check usage of `--config` with the `--help` flag.")
					}
				}
				'--ignore-config' {
					ignore_config_ = true
				}
				else {}
			}
		}
	}

	return Config {
		overriden_ascii: overriden_ascii_
		single_info:     single_info_
		custom_config:   custom_config_
		ignore_config:   ignore_config_
	}
}

fn main() {
	println(parse_args())
}
