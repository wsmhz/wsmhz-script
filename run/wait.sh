until [[ -z `wget -qO- http://127.0.0.1:8082/info | grep app` ]]; 
	do sleep 1 && echo "Config Server Starting Wait...";
done;
find ./ -name "*.jar" -exec java -jar {}\;