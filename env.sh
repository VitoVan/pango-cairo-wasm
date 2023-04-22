################
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.
################

export magicdir=$(pwd)/
export magicprefix=${magicdir}/build

export MAKEFLAGS="-j$(nproc)"
export EM_PKG_CONFIG_PATH=${magicprefix}/lib/pkgconfig/
export PKG_CONFIG_PATH=${magicprefix}/lib/pkgconfig/
export EM_PKG_CONFIG_LIBDIR=${magicprefix}/lib/
export PKG_CONFIG_LIBDIR=${magicprefix}/lib/
export CHOST="wasm32-unknown-linux"
export ax_cv_c_float_words_bigendian=no

${magicdir}/emsdk/emsdk install latest
${magicdir}/emsdk/emsdk activate latest
source ${magicdir}/emsdk/emsdk_env.sh

export MESON_CROSS="${magicdir}/emscripten-crossfile.meson"
# copied from:
# https://gist.github.com/kleisauke/acfa1c09522705efa5eb0541d2d00887
cat > "${magicdir}/emscripten-crossfile.meson" <<END
[binaries]
c = 'emcc'
cpp = 'em++'
ld = 'wasm-ld'
ar = 'emar'
ranlib = 'emranlib'
pkgconfig = ['emconfigure', 'pkg-config']
# https://docs.gtk.org/glib/cross-compiling.html#cross-properties
[properties]
growing_stack = true
have_c99_vsnprintf = true
have_c99_snprintf = true
have_unix98_printf = true
# Ensure that '-s PTHREAD_POOL_SIZE=*' is not injected into .pc files
[built-in options]
c_thread_count = 0
cpp_thread_count = 0
[host_machine]
system = 'emscripten'
cpu_family = 'wasm32'
cpu = 'wasm32'
endian = 'little'
END
