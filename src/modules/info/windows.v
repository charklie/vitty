module info

import os

pub fn windows_package_managers() []string {
	possible_managers := ['winget', 'choco', 'scoop', 'ninite', 'brew', "pip"]

	return possible_managers.filter(os.exists_in_system_path(it)
		|| os.exists_in_system_path('${it}.exe'))
}

pub fn windows_package_count() i16 {
	managers := windows_package_managers()

	mut count := i16(0)

	for manager in managers {
		match manager {
			'scoop' {
				result := os.execute("cd ; (Get-ChildItem | Measure-Object).Count")
				println(result)
			}
			else {}
		}
	}

	return count
}
