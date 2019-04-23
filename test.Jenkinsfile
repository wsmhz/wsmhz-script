import groovy.json.JsonSlurper
import groovy.json.JsonBuilder
node {
   	echo "start"


    def object =  new JsonSlurper().parseText("$payload")
    String refs= new JsonBuilder("$object.ref" ).toPrettyString()
    echo "${refs}"
    echo "end"
}