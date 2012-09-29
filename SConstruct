from subprocess import check_output
from sys import path; path.append('./alice/')
import compile_resources

env = Environment()

if env['PLATFORM'] == 'posix':
	hardware = check_output("grep Hardware /proc/cpuinfo | cut -d ':' -f 2", shell=True).strip()
	if hardware == 'BCM2708':
		env.Replace(PLATFORM='raspi')

compile_resources.add_scons_builder(Builder, env)

SConscript('alice/src/SConscript', exports='env', variant_dir='alice/build')
SConscript('src/SConscript', exports='env', variant_dir='build')
