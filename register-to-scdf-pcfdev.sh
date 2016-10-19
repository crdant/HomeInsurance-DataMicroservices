export SCDF_BUILD_PATH=/Users/crdant/Source/spring-cloud-dataflow
export DEMO_PATH=/Users/crdant/Source/demos/HomeInsurance-DataMicroservices

java -Djavax.net.ssl.trustStorePassword=dataflow -Djavax.net.ssl.trustStore=dataflow.truststore -jar $SCDF_BUILD_PATH/spring-cloud-dataflow-shell-1.0.1.RELEASE.jar --dataflow.uri="https://dataflow-server.local.pcfdev.io" --spring.shell.commandFile="scripts/streams-shell.txt"
