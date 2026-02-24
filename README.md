# Personal Portfolio: Cloud Resume Website

A fully-hosted cloud-based personal portfolio website showcasing my projects, certifications, and technical skills. Built with a focus on AWS services, networking, security, routing, Terraform infrastructure as code, and API integration.

Live site: www.isaac-douglas.com


Features

Visitor Counter: Tracks website visitors using AWS Lambda, DynamoDB, and API Gateway.

Cloud Hosting: Website deployed on AWS S3 with secure routing and SSL.

Infrastructure as Code: Entire AWS setup provisioned via Terraform.

Technical Showcase: Highlights projects, certifications, and technical skills in a clean, responsive design.

API Integration: Dynamic visitor counter updates through backend API calls.

Security & Networking: Implemented proper IAM roles, S3 bucket policies, and routing configurations for secure access.


Tech Stack
Category	Tools / Services
Cloud	AWS S3, AWS Lambda, AWS DynamoDB, API Gateway
IaC	Terraform
Frontend	HTML, CSS, JavaScript
Networking & Security	Route 53, SSL, IAM policies
Other	GitHub for version control, GitHub Pages (if needed for frontend hosting)


Project Structure
CloudResume/
│
├─ assets/           # Images, icons, and static assets
├─ css/              # Stylesheets
├─ js/               # Frontend JavaScript
├─ infrastructure/   # Terraform scripts for AWS resources
├─ index.html        # Main landing page
└─ README.md         # Project documentation
Deployment / Setup

Prerequisites: Terraform installed, AWS CLI configured with proper credentials.


Clone repository

git clone https://github.com/DUGE331/CloudResume.git
cd CloudResume


Deploy infrastructure via Terraform

cd infrastructure
terraform init
terraform apply

Follow prompts to approve resource creation.

Upload website to S3

Use the Terraform deployment or manually sync index.html, css/, js/, and assets/ to the S3 bucket.

API Configuration

Lambda function integrated with API Gateway handles visitor count updates.

DynamoDB table stores visitor data securely.

Access your site

Visit the domain configured via Route 53 / S3 static hosting.

Visitor counter will automatically increment with each new page load.


Learning Outcomes

Proficient in deploying static websites to AWS S3 with serverless backend functionality.

Hands-on experience with Terraform for managing cloud infrastructure.

Understanding of API Gateway, Lambda, and DynamoDB integration.

Applied networking, security, and routing best practices in a cloud environment.


Future Improvements

Add authentication for personalized dashboard access.

Implement CI/CD pipeline for automated deployments.

Expand API integrations for dynamic project data.
