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

        echo " "
        echo "--------------------------------------------------------"
        echo "Use -h to display this! eg. "source main.sh -h""
        echo " "
        echo 'Use -d for debugging! eg. "source main.sh -d output.log"'
        echo " "
        echo 'Use -v for verbose! eg. "source main.sh -v"'
        return 1

    elif [ $1 = -d ]; then

        if [ $2 = -v ]; then

            echo "ERROR: Please give a file name for debugging!"
            return 0

        elif [  $2 = -h ]; then

            echo "ERROR: Please give a file name for debugging!"
            return 0

        elif [ $2 != null ]; then

            if [ $3 = -v ]; then

                sudo docker build --progress=plain -t 'pangocairowasm' . 2>&1 | tee $2

            else

                sudo docker build -t 'pangocairowasm' . 2>&1 | tee $2
            
            fi

        else

            echo "ERROR: Please give a file name for debugging!"
            return 0

        fi

    elif [ $2 = -v ]; then

        if [ $3 = -d ]; then

            if [ $4 = -v ]; then

                echo "ERROR: Please give a file name for debugging!"
                return 0

            elif [ $4 = -h ]; then

                echo "ERROR: Please give a file name for debugging!"
                return 0

            elif [ $4 != null ]; then

                sudo docker build --progress=plain -t 'pangocairowasm' . 2>&1 | tee $4

            else

                echo "ERROR: Please give a file name for debugging!"
                return 0

            fi

        elif [ $3 = -h ]; then

            echo " "
            echo "--------------------------------------------------------"
            echo "Use -h to display this! eg. "source main.sh -h""
            echo " "
            echo 'Use -d for debugging! eg. "source main.sh -d output.log"'
            echo " "
            echo 'Use -v for verbose! eg. "source main.sh -v"'
            return 1

        else

            sudo docker build --progress=plain -t 'pangocairowasm' .

        fi
    
    elif [ $1 = -v ]; then

        if [ $2 = -d ]; then

            if [ $3 = -v ]; then

                echo "ERROR: Please give a file name for debugging!"
                return 0

            elif [ $3 = -h ]; then

                echo "ERROR: Please give a file name for debugging!"
                return 0

            elif [ $3 != null ]; then

                sudo docker build --progress=plain -t 'pangocairowasm' . 2>&1 | tee $3

            else

                echo "ERROR: Please give a file name for debugging!"
                return 0

            
            fi
        
        elif [ $2 = -h ]; then

            echo " "
            echo "--------------------------------------------------------"
            echo "Use -h to display this! eg. "source main.sh -h""
            echo " "
            echo 'Use -d for debugging! eg. "source main.sh -d output.log"'
            echo " "
            echo 'Use -v for verbose! eg. "source main.sh -v"'
            return 1

        elif [ $2 = null ]; then

            sudo docker build --progress=plain -t 'pangocairowasm' .

        fi

    elif [ $1 = null ]; then

        sudo docker build -t 'pangocairowasm' .

    fi

### End Of File ###