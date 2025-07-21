# Docker GHA Training

The goal of this training is to learn how to use Docker and GitHub Actions to build, test and deploy a simple web application. In this training, we will use a simple web application written in Python and Flask.

## GitHub Actions Workflows

This project includes two GitHub Actions workflows:

### 1. Build and Push Docker Image

This workflow builds a Docker image and pushes it to Docker Hub when changes are pushed to the main branch.

- **File**: `.github/workflows/docker-build-push.yml`
- **Triggers**: Push to main branch, Pull requests to main branch
- **Actions**:
  - Builds the Docker image
  - Pushes to Docker Hub (only when on main branch)
  - Tags the image with 'latest' and the commit SHA

### 2. Build and Test

This workflow builds the project and runs tests to ensure code quality.

- **File**: `.github/workflows/build-and-test.yml`
- **Triggers**: Push to main branch, Pull requests to main branch
- **Actions**:
  - Sets up Python environment
  - Installs dependencies
  - Runs linting with flake8
  - Runs tests with pytest

## Setup Instructions

### Docker Hub Secrets

To enable the Docker image push workflow, you need to set up the following secrets in your GitHub repository:

1. Go to your GitHub repository → Settings → Secrets and variables → Actions
2. Add the following secrets:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token (not your password)

### Creating a Docker Hub Access Token

1. Log in to [Docker Hub](https://hub.docker.com/)
2. Go to Account Settings → Security
3. Click "New Access Token"
4. Give it a description (e.g., "GitHub Actions")
5. Copy the token and add it as a secret in your GitHub repository

## Running the Application

### Using Docker

```bash
# Build the Docker image
docker build -t myapp:latest .

# Run the container
docker run -p 8080:5000 myapp:latest
```

### Using Docker Compose

```bash
cd myapp
docker-compose up
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
