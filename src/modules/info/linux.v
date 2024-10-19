module info

import os

pub fn linux_os_release() string {
	if os.is_file('/etc/lsb-release') {
		mut buf := []string{}

		buf << os.read_lines('/etc/lsb-release') or {
			panic("Couldn't read from '/etc/lsb-release'.")
		}

		for idx, it in buf {
			if it.starts_with('DISTRIB_ID') {
				line := buf[idx].split('=')
				return line.last()
			}
		}
	}

	return 'Unknown'
}

pub fn linux_package_managers() []string {
	possible_managers := [
		'xbps-query',
		'dnf',
		'rpm',
		'apt',
		'pacman',
		'emerge',
		'yum',
		'zypper',
		'apk',
		'pkg_info',
		'pkg',
	]

	return possible_managers.filter(fn (manager string) bool {
		version_command := match manager {
			'pkg_info' { '-V' }
			'emerge' { '--help' }
			else { '--version' }
		}

		result := os.execute('${manager} ${version_command}')
		return result.exit_code == 0
	})
}
