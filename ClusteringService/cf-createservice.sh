cf cups gpdb -p '{"URL":"jdbc:postgresql://host.pcfdev.io:5432/gemfire?user=pivotal&password=pivotal"}'
cf create-service p-redis shared-vm redis
