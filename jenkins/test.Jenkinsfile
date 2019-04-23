import groovy.json.JsonSlurperClassic 
import groovy.json.JsonBuilder
@NonCPS
def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}
node {
   	echo "start"

   	echo "$payload"
    def object =  jsonParse("$payload")
    
    String refs= new JsonBuilder("$object.ref" ).toPrettyString()
    echo "${refs}"
    String repository= new JsonBuilder("$object.repository" ).toPrettyString()
    echo "${repository}"
    String name= new JsonBuilder("$object.repository.name" ).toPrettyString()
    echo "${name}"

    
    echo "end"
}