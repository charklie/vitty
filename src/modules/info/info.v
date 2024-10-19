module info

import shared { c_to_f }
import os

struct CPU {
	model     string
	vendor    string
	speed_ghz f32
	temp_c    f32
	temp_f    f32
	cores     int
}

struct GPU { // TODO
	vendor              string
	model               string
	driver_v            string
	vram_gb             int
	temp_c              f32
	temp_f              f32
	utilization_percent int // %
}

struct Mem {
	total_gb f32
	used_gb  f32
}

struct Machine {
	hostname string
	username string
}

struct OperatingSystem {
	distro string
}

struct Kernel {
	kernel string
}

struct Timezone {
	zone string
}

struct Packages {
	count    i16
	managers []string
}

struct Terminal {
	name string
}

struct Shell {
	name string
}

struct WM {
	name string
}

struct Uptime {
	days    int
	hours   int
	minutes int
	seconds int
}

struct Disk {
	location     string
	used_gb      f32
	total_gb     f32
	used_percent f32 // %
}

fn fetch_cpu() CPU {
	mut model := 'i9 99999K'
	mut vendor := 'Intel'
	mut speed_ghz := f32(9.8)
	mut temp_c := f32(32.9)
	mut temp_f := c_to_f(temp_c)
	mut cores := 48

	return CPU{model, vendor, speed_ghz, temp_c, temp_f, cores}
}

fn fetch_gpu() GPU {
	mut model := 'RTX 5090 ULTRA'
	mut vendor := 'NVidia'
	mut driver_v := '999.32.2'
	mut vram_gb := 32
	mut temp_c := f32(32.9)
	mut temp_f := c_to_f(temp_c)
	mut utilization_percent := 30

	return GPU{model, vendor, driver_v, vram_gb, temp_c, temp_f, utilization_percent}
}

fn fetch_mem() Mem {
	mut total_gb := f32(64.0)
	mut used_gb := f32(32.0)

	return Mem{total_gb, used_gb}
}

fn fetch_machine() Machine {
	mut hostname := os.hostname() or { '' }
	mut username := os.getenv('USER')

	return Machine{hostname, username}
}

fn fetch_packages() Packages {
	mut count := i16(32000)
	mut managers := ['apt', 'dpkg', 'snap']

	return Packages{count, managers}
}

fn fetch_terminal() Terminal {
	mut name := 'Kitty'

	return Terminal{name}
}

fn fetch_shell() Shell {
	mut name := 'ZSH'

	return Shell{name}
}

fn fetch_wm() WM {
	mut name := match os.user_os() {
		'windows' { 'Windows WM' }
		else { 'Hyprland' }
	}

	return WM{name}
}

pub fn wm() string {
	return fetch_wm().name
}

fn fetch_uptime() Uptime {
	mut days := 3
	mut hours := 15
	mut minutes := 42
	mut seconds := 6

	return Uptime{days, hours, minutes, seconds}
}

pub fn uptime() string {
	raw := fetch_uptime()
	parts := [
		if raw.days > 0 { '${raw.days} day' + if raw.days > 1 { 's' } else { '' }
		 } else { ''
		 },
		if raw.hours > 0 { '${raw.hours} hour' + if raw.hours > 1 { 's' } else { '' }
		 } else { ''
		 },
		if raw.minutes > 0 { '${raw.minutes} minute' + if raw.minutes > 1 { 's' } else { '' }
		 } else { ''
		 },
		if raw.seconds > 0 { '${raw.seconds} second' + if raw.seconds > 1 { 's' } else { '' }
		 } else { ''
		 },
	].filter(it != '')
	return parts.join(', ')
}

fn fetch_disk() Disk {
	mut location := '/dev/sda'
	mut used_gb := f32(567.3)
	mut total_gb := f32(2000.9)
	mut used_percent := f32(26.2)

	return Disk{location, used_gb, total_gb, used_percent}
}

pub fn disk() string {
	raw := fetch_disk()
	return '(${raw.location}) ${raw.used_gb}/${raw.total_gb} (${raw.used_percent})'
}

fn fetch_os_name() string {
	return match os.user_os() {
		'linux' { linux_os_release() }
		'windows' { os.uname().sysname }
		else { 'Unknown' }
	}
}
