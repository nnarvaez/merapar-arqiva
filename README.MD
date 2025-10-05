# Dynamic HTML Service with Terraform and AWS

## 🧠 Overview

This project provisions a serverless service on AWS that serves a dynamic HTML page. The string in the page can be updated without redeploying the infrastructure.

## 🌐 Live Behavior

Accessing the public URL returns:

```html
<h1>The saved string is dynamic string</h1>

Terraform: Infrastructure as Code

AWS Lambda: Backend logic

API Gateway: Public endpoint

DynamoDB: Stores the dynamic string

Structure

dynamic-html-service/
├── terraform/
│   ├── main.tf
│   ├── lambda.tf
│   ├── dynamodb.tf
│   ├── iam.tf
│   ├── api_gateway.tf
│   └── outputs.tf
├── lambda/
│   ├── handler.py
│   └── function.zip
├── README.md
└── documentation/
    └── solution.pdf

# Zip Lambda
Compress-Archive -Path .\lambda\handler.py -DestinationPath .\lambda\function.zip -Force

# Deploy with Terraform
terraform init
terraform apply -auto-approve

aws dynamodb put-item `
  --table-name DynamicStringTable `
  --item '{"id": {"S": "string"}, "value": {"S": "New dynamic string"}}'

Interview Notes
URL stays constant

No redeploy needed to change string

All users see the same result

✨ Future Enhancements
Admin UI to update string

CI/CD pipeline

Multi-language support
