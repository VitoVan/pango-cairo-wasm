################
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.
################

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
