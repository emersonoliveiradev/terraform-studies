[
  {
    "name": "${NAME}",
    "image": "${AWS_ECR_ARN}:latest",
    "cpu": 512,
    "memory": 400,
    "essential": true,
    "command": ["python", "__init__.py"],
    "networkMode": "bridge",
    "environment": [${ENVIRONMENT}],
    "secrets": [${SECRET}],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${AWS_LOGS_GROUP}",
        "awslogs-region": "${AWS_REGION}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
