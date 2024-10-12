### C2MAN Build Script ###

    ### Close Docker on Error ###
    
        set -e

    ### Cloning C2MAN ###

        git clone https://github.com/fribidi/c2man.git
    
    ### Configuring C2MAN ###

        cd c2man
        ./Configure -dE
        mkdir -p $(pwd)/c2man-install
        echo "binexp=$(pwd)/c2man-install" >> config.sh
        echo "installprivlib=$(pwd)/c2man-install" >> config.sh
        echo "mansrc=$(pwd)/c2man-install" >> config.sh
        sh config_h.SH
        sh flatten.SH
        sh Makefile.SH

    ### Building C2MAN ###

        make depend
        make
        make install

    ### End Of Code ###

### End Of File ###