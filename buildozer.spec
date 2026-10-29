[app]
title = Jarvis Pro
package.name = jarvispro
package.domain = org.hadhoufa
source.dir = .
source.include_exts = py,png,jpg,kv,atlas
version = 1.0.0
# THE REAL FIX: Force hostpython3 to match the server's version
requirements = python3,kivy==2.3.1,cython==0.29.34,hostpython3==3.11.17
orientation = portrait
fullscreen = 0
android.permissions = INTERNET
android.api = 31
android.minapi = 21
android.ndk = 25b
android.accept_sdk_license = True
android.archs = arm64-v8a, armeabi-v7a
p4a.branch = master
