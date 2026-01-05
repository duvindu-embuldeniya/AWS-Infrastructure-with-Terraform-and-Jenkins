# AWS Infrastructure with Terraform and Jenkins

![Project Banner](https://drive.google.com/uc?export=view&id=1qx-3so095f0DlO0LwoD5Vo7YU-JedrEv)

A repository demonstrating AWS infrastructure provisioning with Terraform and CI/CD automation using Jenkins.

---

## Tech Stack

![Tech Stack](https://drive.google.com/uc?export=view&id=1tqwYJFscuV1e2U-cH3eQjMnL66nKNNpH)

Source: [Tech Stack image](https://drive.google.com/file/d/1tqwYJFscuV1e2U-cH3eQjMnL66nKNNpH/view?usp=drive_link)

---

## Jenkins Procedure

![Jenkins Procedure](https://drive.google.com/uc?export=view&id=1oAz2BRyt5-LQTddAvGfgpvW1h6Mdfap1)

Source: [Jenkins Procedure image](https://drive.google.com/file/d/1oAz2BRyt5-LQTddAvGfgpvW1h6Mdfap1/view?usp=drive_link)

---

## Getting Started

Follow these steps to run the application locally and to understand the project's structure.

Prerequisites
- Git
- Python 3.8+ (if running the Django app)
- pip
- virtualenv (optional but recommended)
- Terraform (for infra provisioning)
- Jenkins (for CI/CD)

1. Clone the repository
```bash
git clone https://github.com/duvindu-embuldeniya/AWS-Infrastructure-with-Terraform-and-Jenkins.git
cd AWS-Infrastructure-with-Terraform-and-Jenkins
```

2. (Optional) Create and activate a Python virtual environment
- Install virtualenv if missing:
```bash
pip install virtualenv
```
- Create the environment:
```bash
virtualenv envname
```
- Activate:
  - On Windows:
  ```bash
  envname\Scripts\activate
  ```
  - On macOS / Linux:
  ```bash
  source envname/bin/activate
  ```

3. Install Python requirements (if present)
```bash
pip install -r requirements.txt
```

4. Run the Django application (if applicable)
```bash
python manage.py migrate
python manage.py runserver
```
The development server will be available at http://127.0.0.1:8000/

5. Terraform (infrastructure)
- Navigate to the Terraform directory (e.g., `terraform/`), inspect `.tf` files, and initialize:
```bash
cd terraform
terraform init
terraform plan
terraform apply
```
- Ensure AWS credentials are configured (environment variables or shared credentials file).

6. Jenkins (CI/CD)
- Use the Jenkins Procedure image above as a quick reference for job setup and pipeline configuration.
- Typical steps:
  - Install required plugins (Git, Pipeline, AWS, Terraform if used).
  - Create a pipeline job pointing to this repo.
  - Configure credentials (Git, AWS) in Jenkins.
  - Use a Jenkinsfile in the repo (or create one) to define CI/CD stages (lint/test/build/deploy).

---

## Project Structure (example)
- terraform/          — Terraform configs for AWS resources
- jenkins/            — Jenkinsfiles or pipeline helpers
- app/ or project/    — Django project files (manage.py, settings, etc.)
- requirements.txt

(Adjust paths above to match the actual repo layout.)

---

## Contributing
1. Fork the repo
2. Create a feature branch
3. Open a pull request with a clear description
