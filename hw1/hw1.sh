
#!/bin/bash

MAXPOINTS=$1
IFS='/'
export GREP_COLORS="ms=01;32";
echo "Maximum score ${MAXPOINTS}";
for DIR in students/*
    do  
        read -a strarr <<< "$DIR";
        NAME="${strarr[1]}"
        echo "Processing ${NAME} ...";
        if test -f "${DIR}"/task1.sh; then
            "$DIR"/task1.sh > ./tmp.txt;
            NUM_ERRORS=$(diff -w expected.txt ./tmp.txt | grep '<\|>' | wc -l | sed 's/ //g');
            declare -i NUM_ERRORS;
            if (( $NUM_ERRORS > 0 )); then
                echo "${NAME} has incorrect output (${NUM_ERRORS} lines do not match)";
            fi
            POINTS=$(($MAXPOINTS-$NUM_ERRORS*5));
            RESULT=$((POINTS<0 ? 0 : POINTS));
            echo "${NAME} has earned a score of ${RESULT} / 50";
            rm ./tmp.txt
        else
            echo "${NAME} did not turn in assignment";
        fi
        echo "\n";       
done
