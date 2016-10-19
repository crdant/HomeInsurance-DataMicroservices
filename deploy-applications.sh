DEMO_PATH=/Users/crdant/Source/demos/HomeInsurance-DataMicroservices

cf login -a https://api.local.pcfdev.io -u admin -p admin -o demos -s insurance --skip-ssl-validation

pushd $DEMO_PATH/SensorEventConsole
. ./cf-createservice.sh
cf push
popd

pushd $DEMO_PATH/ClusteringService
. ./cf-createservice.sh
cf push
curl http://clustering-service.local.pcfdev.io/clustering/train
popd
