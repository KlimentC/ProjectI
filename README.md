# ProjectI

Objective: To automate the application development and deployment process using DevOps methodologies.

Business Value:

Increased Efficiency:
-Automated deployments: Minimize manual intervention, reducing human error and accelerating time-to-market for new features and updates.
-Continuous Integration/Continuous Delivery (CI/CD): Automate the build, test, and deployment pipeline, enabling frequent and reliable releases.
Improved Quality:
-Robust testing: Incorporate unit tests and automated testing frameworks to ensure code quality and identify issues early in the development cycle.
-Infrastructure as Code (IaC): Manage and provision infrastructure ( EC2 instances) using Terraform, ensuring consistency and repeatability.
Enhanced Collaboration:
-Shared code repository (GitHub): Facilitate collaboration among developers and streamline code reviews.
Cost Optimization:
-Reduced manual effort: Free up developers from repetitive tasks, allowing them to focus on innovation.
Key Technologies:

-Python: Application development language.
-Terraform: Infrastructure as Code tool for managing AWS resources.
-Flyway: Database migration tool.
-Packer: Tool for building and managing machine images.
-Ansible: Automation platform for configuring and managing IT infrastructure.
-GitHub Actions: CI/CD platform for automating workflows.

Project Structure:

-app: Contains the core application code, including unit tests, dependencies, etc.
-AnsibleConfig: Holds Ansible configuration files for managing EC2 instances and dependencies.
-deployment: Stores deployment-related configuration (e.g., replicas, port).
-dotFile: Stores editorconfig for consistent code style that is used in the CI process
-IacCpChck: Contains Terraform files for managing EC2 instances from custom AMIs.
-imageBacker: Contains Packer configuration for building custom AMIs.

Conclusion:

By leveraging these DevOps methodologies and technologies, ProjectI aims to showcase efficiency, quality, and reliability of the application development and deployment process, ultimately delivering greater value to the business.
