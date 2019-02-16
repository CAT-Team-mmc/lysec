#!/bin/bash

i=1;
MAX_INSERT_ROW_COUNT=$1;
while [ $i -le $MAX_INSERT_ROW_COUNT ]
do
    mysql -h5678102f1b5bb.sh.cdb.myqcloud.com -P15368 -uroot -pwechat@1234 platform -e "INSERT INTO users (username, password, name, role, email, active, phone, icon_url) VALUES ('user$i', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'user$i', 'user$i', '$i@qq.com', '1', '1533532$i', '1231')"
	    d=$(date +%M-%d\ %H\:%m\:%S)
		echo "INSERT INTO users (username, password, name, role, email, active, phone, icon_url) VALUES ('user$i', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'user$i', 'user$i', '$i@qq.com', '1', '15335335$i', '1231')"
	    echo "INSERT HELLO $i @@ $d"    
		    i=$(($i+1))
	    sleep 0.05
		done

		exit 0
