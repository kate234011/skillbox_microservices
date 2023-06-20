
echo 'Starting profile "EKP": ekp.old(include test data) + 7 schemas + 6 tc2 + ui'
  docker-compose \
    up -d

  docker network create first_stage

  docker network connect first_stage postgresdb
  docker network connect first_stage pgadmin4
