# Environment variables
# If you use CICD pipeline, you can define into your pipeline settings
export DOCKER_HUB_REGISTRY=<YOUR DOCKER HUB REGISTRY>
export DOCKER_HUB_RELEASE_TAG=release
export AWS_RELEASE_TAG=release
export AWS_REGISTRY_URL=<YOUR AWS REGISTRY>

# docker image pull
docker pull $DOCKER_HUB_REGISTRY_IMAGE:$DOCKER_HUB_RELEASE_TAG
$(aws ecr get-login --no-include-email --region $AWS_REGION | tr -d '\r')

# tagging
docker tag $DOCKER_HUB_REGISTRY_IMAGE:$DOCKER_HUB_RELEASE_TAG $AWS_REGISTRY_URL:$AWS_RELEASE_TAG
# docker image to AWS registry
docker push $AWS_REGISTRY_URL:$AWS_RELEASE_TAG

# update task and service using AWS ECS cli
aws ecs register-task-definition --family ecs-web --requires-compatibilities EC2 --cpu 256 --memory 512 --cli-input-json file://depoloyment/task-definition.json --region $AWS_REGION
aws ecs update-service --cluster ecsCluster --service web --task-definition ecs-web --region $AWS_REGION