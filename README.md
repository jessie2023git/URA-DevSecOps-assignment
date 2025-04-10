# URA Sample Project

Welcome to the URA take-home assignment sample project. In this repo, you will find a barebones frontend web application in React + TypeScript + Vite.

You do not need to develop the frontend application. The purpose of this assignment is to set up the build, IaC and CI/CD scripts to enable a development workflow that involves multiple feature environments.

The main requirements are as follows:

1. Write a Dockerfile to containerize this application.
2. Write a Terraform script to provision the required resources on AWS to run the application. Deploy the container using ECS Fargate. Note that you do not need to actually deploy anything, only the creation of the Terraform script is required.
3. Write a GitLab CI/CD script to automatically build and deploy the `main` branch. Like step 2. you do not need to actually run this script.
4. The CI/CD script should also detect when a feature branch is pushed and automatically create a new deployment. Feature branches must following this naming convention: **feature-{featureName}**.
5. Assume that there is an existing API Gateway with the name "sample-app-apigw". This APIGW will also already have a path `/feature/` in addtion to the root resource `/`.
6. The root resource of the APIGW should point to the ECS cluster that runs the `main` branch.
7. The separate feature branches will each have their own resource on the APIGW. For example, when a branch named `featre-myFeature` is pushed, there should a be a new APIGW resource created at `/feature/myFeature` and the ECS cluster running the branch should be accessible from this resource.
