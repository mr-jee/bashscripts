#!/bin/bash

#taking params from user
read -p "Min size in MB: " MIN
read -p "Max size in MB: " MAX
read -p "Destinaion directory: " DEST
read -p "How many files? " COUNT


#check if the dest directory exist
if [ ! -d "$DEST" ]; then
        echo -n "Ther's no directory '$DEST',\n Do you want to create it?(y/n) "
        read  CONFIRM

        if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
                mkdir -p "$DEST"
                echo -e "\nThe path: **_ $DEST _** is created!\n"
        else
                echo -e "Operation Cancelled, Theres no such directory\n"
                exit 1
        fi
fi

#producing files in random size

for i in `seq 1 $COUNT`; do
        SIZE=$(( (RANDOM % ($MAX - $MIN + 1)) + $MIN ))
        FILE="$DEST/logfile_$(date +%F_%H:%M)_$i.log"
        echo -e "Creating file $FILE with size of ${SIZE}MB...\n"
        base64 /dev/random | head -c ${SIZE}M > "$FILE" #we put " around FILE because we want the whole directory with all / and characters get written with no error
done

echo -e "\nALL files are created:\n"
ls -lh "$DEST"

