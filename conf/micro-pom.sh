cat > micro-pom.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <groupId>template</groupId>
    <artifactId>template</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>${project.artifactId}</name>

    <parent>
        <artifactId>micro-service-parent</artifactId>
        <groupId>com.wsmhz.common</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>


</project>
EOF