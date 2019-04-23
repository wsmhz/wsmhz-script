import groovy.json.JsonSlurper
import groovy.json.JsonBuilder
node {
   	echo "start"

    def object =  new JsonSlurper().parseText("$payload")
    
    String refs= new JsonBuilder("$object.ref" ).toPrettyString()
    echo "${refs}"
    String repository= new JsonBuilder("$object.repository" ).toPrettyString()
    echo "${repository}"
    String name= new JsonBuilder("$object.repository.name" ).toPrettyString()
    echo "${name}"

    
    echo "end"
}