[app]
title = Jarvis Pro
package.name = jarvispro
package.domain = org.hadhoufa
source.dir = .
source.include_exts = py,png,jpg,kv,atlas
version = 1.0.0
# THE REAL FIX: Force hostpython3 to match the server's version
requirements = python3==3.11.9, kivy==2.3.1, cython<3.0.0
orientation = portrait
fullscreen = 0
android.permissions = INTERNET
android.api = 33
android.minapi = 24
android.ndk = 25b
android.accept_sdk_license = True
android.archs = arm64-v8a, armeabi-v7a


[buildozer]
warn_on_root = 1
log_level = 2
android.skip_update = False
