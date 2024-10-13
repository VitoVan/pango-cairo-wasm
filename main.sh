### C2MAN Setup ###

    cd c2man
    docker build -t 'c2man' .
    c2manImage=c2man
    c2manContainer_id=$(docker create "$c2manImage")
    c2manSource_path=/main/c2man/c2man-install

    cd ../fribidi
    mkdir c2man
    sudo docker cp "$c2manContainer_id:$c2manSource_path" ./c2man
    cd ../

### Args ###

    if [ $1 = -h ]; then

        echo "Use -h to display this!"
        echo " "
        echo "Use -d for debugging! eg.
         -d output.log"

    elif [ $1 = -d ]; then

        if [ $2 != null ]; then

            sudo docker build --progress=plain -t 'pangocairowasm' . | tee $2

        else

            echo "ERROR: Please give a file name for debugging!"
            exit 0

        fi
    
    else

        sudo docker build -t 'pangocairowasm' .

    fi

### End Of File ###