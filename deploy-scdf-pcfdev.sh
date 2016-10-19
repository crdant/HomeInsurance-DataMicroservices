export SCDF_BUILD_PATH=/Users/crdant/Source/spring-cloud-dataflow

cf dev start -m 8192
cf dev trust
security find-certificate -a -p /Users/crdant/Library/Keychains/pcfdev.keychain-db > dataflow_cert
rm -f dataflow.truststore
keytool -importcert -keystore dataflow.truststore -alias dataflow -storepass dataflow -file dataflow_cert -noprompt
rm dataflow_cert

cf login -a https://api.local.pcfdev.io -u admin -p admin -o pcfdev-org -s pcfdev-space --skip-ssl-validation
cf create-org demos
cf target -o demos
cf create-space insurance -o demos
cf target -o demos -s insurance

cf create-service p-redis shared-vm redis
cf create-service p-rabbitmq standard rabbit
cf push dataflow-server -m 1536M -k 2G --no-start -p $SCDF_BUILD_PATH/spring-cloud-dataflow-server-cloudfoundry-1.0.1.RELEASE.jar
cf bind-service dataflow-server redis
cf bind-service dataflow-server rabbit

# configure the container
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_URL http://api.local.pcfdev.io
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_ORG demos
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SPACE insurance
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_DOMAIN local.pcfdev.io
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_USERNAME admin
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_PASSWORD admin
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SKIP_SSL_VALIDATION true

cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_BUILDPACK java_buildpack
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_ENABLE_RANDOM_APP_NAME_PREFIX false
cf set-env dataflow-server MAVEN_REMOTE_REPOSITORIES_REPO1_URL http://192.168.11.1:6840
cf set-env dataflow-server MAVEN_REMOTE_REPOSITORIES_REPO2_URL https://repo.spring.io/libs-snapshot


# configure the microservices the container creates
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_MEMORY 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_DISK 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_MEMORY 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_DISK 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_SERVICES rabbit,redis,gemfire
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_SERVICES rabbit,redis,gemfire

# enable tasks
cf set-env dataflow-server SPRING_CLOUD_DATAFLOW_FEATURES_EXPERIMENTAL_TASK_ENABLED true

cf start dataflow-server
