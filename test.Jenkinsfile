import groovy.json.JsonSlurper
import groovy.json.JsonBuilder
node {
   	echo "start"

    def object =  new JsonSlurper().parseText("$Payload")
    
    String refs= new JsonBuilder("$object.ref" ).toPrettyString()
    echo "${refs}"
    echo "end"
}