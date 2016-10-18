export SCDF_BUILD_PATH=/Users/crdant/Source/spring-cloud-dataflow

cf push dataflow-server -m 1536M -k 2G --no-start -p $SCDF_BUILD_PATH/spring-cloud-dataflow-server-cloudfoundry-1.0.1.RELEASE.jar
cf bind-service dataflow-server redis
cf bind-service dataflow-server rabbit

# configure the container
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_URL http://api.local.pcfdev.io
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_ORG demos
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SPACE fraud
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_DOMAIN local.pcfdev.io
# cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SERVICES rabbit,redis
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_USERNAME admin
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_PASSWORD admin
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_SKIP_SSL_VALIDATION true

cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_BUILDPACK java_buildpack
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_ENABLE_RANDOM_APP_NAME_PREFIX false
cf set-env dataflow-server MAVEN_REMOTE_REPOSITORIES_REPO1_URL https://repo.spring.io/libs-snapshot
cf set-env dataflow-server MAVEN_REMOTE_REPOSITORIES_REPO2_URL http://192.168.11.1:6840


# configure the microservices the container creates
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_MEMORY 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_DISK 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_MEMORY 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_DISK 512
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_TASK_SERVICES rabbit,redis,gemfire
cf set-env dataflow-server SPRING_CLOUD_DEPLOYER_CLOUDFOUNDRY_STREAM_SERVICES rabbit,redis,gemfire

# enable tasks
cf set-env SPRING_CLOUD_DATAFLOW_FEATURES_EXPERIMENTAL_TASK_ENABLED true

cf start dataflow-server
