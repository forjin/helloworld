## This application is hello world service for docker deployment.
  Purpose of this application is service nice hello world return from restful web request.

### prerequisite
  - docker should be installed on the deployment machine(http://www.docker.com)
  - aws cli (https://aws.amazon.com/cli/)
  - docker hub account / repository / login
    `docker login`
  - (optional) `docker-compose` to test application on local

### run local test for your application
  - build
    `docker-compose build`
  - service up : this command changes newly genereated image
    `docker-compose up -d`

### build steps for local or manual deployment and push to the repository
  - build
    `docker build -t web .`
  - run
    `docker run -d 80:5000 --name web web`
  - tag
    `docker tag web <YOUR DOCKER HUB ID>/web:release`
  - push
    `docker push <YOUR DOCKER HUB ID>/web`

### deployment to AWS ECS
  - setup aws key & secret
    `aws configure`
  - need to assign `AmazonEC2ContainerServiceRole` and `AmazonEC2ContainerRegistryFullAccess`
  - create ecs cluster named `ecsCluster` using AWS management console
  - create ecs registry and set as `AWS_REGISTRY` in `deployment/deploy.sh` and `task-definition.json`
  - run command line to execute
    `./deployment/deploy.sh`