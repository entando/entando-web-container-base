while true;
    do
        if [ ! -d /usr/local/tomcat/webapps/CONTEXT_PATH/resources ]; then
            echo "Wait for webapp deployed"
			sleep 5
        else
            echo "Webapp ready, copy resources"
            cp -Rf /usr/local/tomcat/webapps/CONTEXT_PATH/resources /entando-data/
            cp -Rf /usr/local/tomcat/webapps/CONTEXT_PATH/protected /entando-data/
            break
		fi
    done
