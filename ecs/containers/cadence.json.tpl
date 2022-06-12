[
  {
    "name": "cadence",
    "image": "ubercadence/server:master-auto-setup",
    "essential": true,
    "environment": [
      {
        "name": "CASSANDRA_SEEDS",
        "value": "${cassandra_endpoint}"
      },
      {
        "name": "CASSANDRA_USER",
        "value": "${username}"
      },
      {
        "name": "LOG_LEVEL",
        "value": "debug"
      },
      {
        "name": "KEYSPACE",
        "value": "cadence_db"
      },
      {
        "name": "VISIBILITY_KEYSPACE",
        "value": "cadence_db_visibility"
      },
      {
        "name": "NUM_HISTORY_SHARDS",
        "value": "4"
      },
      {
        "name": "DB",
        "value": "cassandra"
      }
    ],
    "secrets": [
      {
        "name": "CASSANDRA_PASSWORD",
        "valueFrom": "${password_arn}"
      }
    ],
    "portMappings": [
      {
        "containerPort": 8000,
        "hostPort": 8000
      },
      {
        "containerPort": 8001,
        "hostPort": 8001
      },
      {
        "containerPort": 8002,
        "hostPort": 8002
      },
      {
        "containerPort": 8003,
        "hostPort": 8003
      },
      {
        "containerPort": 7933,
        "hostPort": 7933
      },
      {
        "containerPort": 7934,
        "hostPort": 7934
      },
      {
        "containerPort": 7935,
        "hostPort": 7935
      },
      {
        "containerPort": 7939,
        "hostPort": 7939
      },
      {
        "containerPort": 7833,
        "hostPort": 7833
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "ap-southeast-1",
        "awslogs-stream-prefix": "cadence-demo-service"
      }
    }
  },
  {
    "name": "cadence-web",
    "image": "ubercadence/web:latest",
    "essential": true,
    "environment": [
      {
        "name": "CADENCE_TCHANNEL_PEERS",
        "value": "localhost:7933"
      }
    ],
    "portMappings": [
      {
        "containerPort": 8088,
        "hostPort": 8088
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "ap-southeast-1",
        "awslogs-stream-prefix": "cadence-ui-demo-service"
      }
    }
  }
]