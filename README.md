# 🚀 Ansible Docker Apps

<div align="center">

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Ansible](https://img.shields.io/badge/Ansible-2.14+-EE0000?logo=ansible)
![Docker](https://img.shields.io/badge/Docker-Required-2496ED?logo=docker)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python)
![Status](https://img.shields.io/badge/Status-Active-success)

**Deploy self-hosted applications with Ansible and Docker**

[Features](#-features) • [Quick Start](#-quick-start) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Available Applications](#-available-applications)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Deployment](#-deployment)
- [Uninstallation](#-uninstallation)
- [Application Access](#-application-access)
- [Project Structure](#-project-structure)
- [Documentation](#-documentation)
- [GitHub Infrastructure as Code](#-github-infrastructure-as-code)
- [Development](#-development)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [Author](#-author)
- [License](#-license)

## 📋 Overview

**Ansible Docker Apps** is an infrastructure-as-code solution for deploying self-hosted applications using Ansible and Docker. It provides a simple, declarative way to manage the lifecycle of containerized applications (deployment, configuration, uninstallation).

Perfect for users who want:

- 🔄 Reproducible application deployments
- 🐳 Containerized applications for isolation
- 🎨 Self-hosted tools (AI interfaces, collaborative whiteboards)
- 🔒 Secure configuration with Ansible Vault

## ✨ Features

- **🎯 One-Command Deployment** - Deploy all applications with a single Ansible playbook
- **🔧 Modular Architecture** - Enable/disable applications individually via simple configuration
- **🐳 Docker-Based** - All applications run in isolated containers
- **🔐 Secure by Default** - Sensitive data encrypted with Ansible Vault
- **🎨 Customizable** - Easy configuration through YAML variables
- **🔄 Version Controlled** - Infrastructure as Code approach
- **📦 Pre-configured** - Ready-to-use setups with sensible defaults
- **✅ Quality Assured** - Pre-commit hooks for code quality (Ansible Lint, YAML Lint, ShellCheck, Terraform validators)

## 📱 Available Applications

The following applications can be deployed and managed through this project:

| Application            | Description                                             | Version | Port   | Official Site                             |
| ---------------------- | ------------------------------------------------------- | ------- | ------ | ----------------------------------------- |
| 🎨**Excalidraw** | Virtual collaborative whiteboard for sketching diagrams | latest  | 8082   | [excalidraw.com](https://excalidraw.com/) |
| 🌐**Open WebUI** | Feature-rich web interface for AI/LLM APIs              | v0.8.3  | 8080   | [openwebui.com](https://www.openwebui.com/) |
| 🐳**Portainer**  | Container management platform for Docker                | 2.33.6  | 9443   | [portainer.io](https://www.portainer.io/) |
| 🔒**Caddy**      | Fast, multi-platform reverse proxy with auto HTTPS      | 2.11-alpine | 80/443 | [caddyserver.com](https://caddyserver.com/) |
| 🎯**Semaphore**  | Modern UI for Ansible, Terraform and other DevOps tools | v2.17.2 | 3000   | [semaphoreui.com](https://semaphoreui.com/) |

### Current Configuration

By default, the following applications are **enabled** in `group_vars/all/main.yml`:

```yaml
deploy_excalidraw: true
deploy_open_webui: true
deploy_portainer: true
deploy_caddy: true
deploy_semaphore: true
```

## ⚡ Quick Start

Get up and running in under 5 minutes:

```bash
# 1. Clone the repository
git clone https://github.com/xgueret/ansible-docker-apps.git
cd ansible-docker-apps

# 2. Install dependencies
uv sync
ansible-galaxy collection install -r requirements.yml

# 3. Configure vault password (using pass)
pass insert ansible/vault

# 4. Deploy!
ansible-playbook deploy.yml
```

Access your applications:

- Open WebUI: <http://localhost:8080>
- Excalidraw: <http://localhost:8082>
- Portainer: <https://localhost:9443>

For detailed setup instructions, see the [Installation](#-installation) section below.

## ✅ Prerequisites

Ensure you have the following installed on your system:

| Requirement          | Version | Purpose                       | Installation                                       |
| -------------------- | ------- | ----------------------------- | -------------------------------------------------- |
| **Python**     | 3.12+   | Run Ansible                   | [python.org](https://www.python.org/)                 |
| **uv**         | Latest  | Python package manager        | [docs.astral.sh/uv](https://docs.astral.sh/uv/)    |
| **Ansible**    | 2.14+   | Automation engine             | `uv sync`                                          |
| **Docker**     | Latest  | Container runtime             | [docs.docker.com](https://docs.docker.com/get-docker/) |
| **Docker Compose** | Latest  | Multi-container orchestration | Included with Docker Desktop                       |
| **pass**       | Latest  | Password manager for vault    | [passwordstore.org](https://www.passwordstore.org/) |
| **Git**        | Latest  | Version control               | [git-scm.com](https://git-scm.com/)                   |

### System Requirements

- **OS**: Linux, macOS, or Windows (WSL2)
- **RAM**: 4GB minimum
- **Disk**: 10GB free space minimum

## 📥 Installation

1. Clone the repository:

```bash
git clone https://github.com/xgueret/ansible-docker-apps.git
cd ansible-docker-apps
```

2. Install Python dependencies:

```bash
uv sync
```

3. Install Ansible collections:

```bash
ansible-galaxy collection install -r requirements.yml
```

4. Configure pre-commit hooks:

```bash
pre-commit install
```

## ⚙️ Configuration

### Ansible Vault Setup

The project uses **Ansible Vault** to securely store sensitive information (passwords, API keys, etc.) with [pass](https://www.passwordstore.org/) as the password manager.

1. Install `pass` if not already installed:

```bash
# Debian/Ubuntu
sudo apt install pass

# macOS
brew install pass
```

2. Initialize pass and store the vault password:

```bash
# Initialize pass (if not done yet)
pass init "your-gpg-id"

# Store the Ansible vault password
pass insert ansible/vault
```

3. The vault configuration uses a wrapper script in `ansible.cfg`:

```ini
vault_password_file = ./scripts/ansible-vault-pass.sh
```

The script `scripts/ansible-vault-pass.sh` retrieves the password from pass:

```bash
#!/bin/bash
pass show ansible/vault
```

### Configuration Files

You can customize the deployment by modifying these configuration files:

| File                        | Purpose                              | Contains                                     |
| --------------------------- | ------------------------------------ | -------------------------------------------- |
| `group_vars/all/main.yml` | **Main configuration**         | App path, network settings, deployment flags |
| `group_vars/all/vault/`   | **Sensitive data (encrypted)** | Passwords, API keys, secrets                 |
| `roles/*/vars/main.yml`   | App-specific settings                | Ports, versions, container names             |
| `ansible.cfg`             | Ansible behavior                     | Inventory, vault, connection settings        |

### Enabling/Disabling Applications

Edit `group_vars/all/main.yml` to control which applications are deployed:

```yaml
deploy_excalidraw: true
deploy_open_webui: true
deploy_portainer: true
deploy_caddy: true
deploy_semaphore: true
```

### Customizing Application Settings

Each application has its own configuration in `roles/<app_name>/vars/main.yml`. For example:

**Excalidraw** (`roles/excalidraw/vars/main.yml`):

```yaml
excalidraw_version: "latest"  # Specify version (no semver tags available)
excalidraw_port: "8082"       # Web interface port
```

**Open WebUI** (`roles/open_webui/vars/main.yml`):

```yaml
open_webui_image: ghcr.io/open-webui/open-webui  # Docker image
open_webui_version: "v0.7.2"                      # Specify version
open_webui_port: 8080                              # Web interface port
```

## 🚀 Deployment

### Deploy All Applications

Deploy all enabled applications with a single command:

```bash
ansible-playbook deploy.yml
```

This will:

1. Create the application directory structure
2. Set up a Docker network (`local_network`)
3. Deploy all applications where `deploy_<app>: true` in configuration
4. Start all containers

### Deploy Specific Applications

Use tags to deploy only specific applications:

```bash
# Deploy only Excalidraw
ansible-playbook deploy.yml --tags "excalidraw"

# Deploy only Open WebUI
ansible-playbook deploy.yml --tags "open_webui"
```

### Available Deployment Tags

| Tag          | Application           | Status               |
| ------------ | --------------------- | -------------------- |
| `excalidraw` | Excalidraw whiteboard | ✅ Active in playbook |
| `open_webui` | Open WebUI interface  | ✅ Active in playbook |
| `portainer`  | Portainer management  | ✅ Active in playbook |
| `caddy`      | Caddy reverse proxy   | ✅ Active in playbook |
| `semaphore`  | Semaphore UI          | ✅ Active in playbook |

### Verify Deployment

After deployment, check that containers are running:

```bash
docker ps
```

You should see containers named:

- `open-webui`
- `excalidraw`
- `portainer`
- `caddy-proxy`
- `semaphore`
- `semaphore-postgres`

## 🗑️ Uninstallation

### ⚠️ Important Warning

Running `uninstall.yml` **without tags** will remove **ALL** applications! Always use tags unless you want to completely reset your environment.

### Uninstall Specific Applications (Recommended)

```bash
# Uninstall a single application
ansible-playbook uninstall.yml --tags "excalidraw"

# Uninstall multiple applications
ansible-playbook uninstall.yml --tags "excalidraw,open_webui"
```

### Uninstall All Applications

```bash
# This will remove EVERYTHING!
ansible-playbook uninstall.yml
```

### What Gets Removed

The uninstall playbook performs the following actions:

- ✅ Stops and removes Docker containers
- ❌ **Preserves** data volumes (must be manually removed if desired)
- ❌ **Preserves** configuration files

### Available Uninstall Tags

All applications support uninstallation via tags:

| Tag          | Application           |
| ------------ | --------------------- |
| `excalidraw` | Excalidraw whiteboard |
| `open_webui` | Open WebUI interface  |
| `portainer`  | Portainer management  |
| `caddy`      | Caddy reverse proxy   |
| `semaphore`  | Semaphore UI          |

### Manual Cleanup (Optional)

To completely remove data and free up disk space:

```bash
# Remove application directory (⚠️ deletes all data!)
rm -rf ~/Workspace/07-local/app

# Remove Docker volumes
docker volume prune

# Remove Docker network
docker network rm local_network
```

## 🔗 Application Access

Once deployed, access your applications through these URLs:

| Application          | URL                    | Description              |
| -------------------- | ---------------------- | ------------------------ |
| 🌐**Open WebUI** | <http://localhost:8080>  | Web interface for AI/LLM |
| 🎨**Excalidraw** | <http://localhost:8082>  | Collaborative whiteboard |
| 🐳**Portainer**  | <https://localhost:9443> | Container management     |
| 🎯**Semaphore**  | <http://localhost:3000>  | Ansible/Terraform UI     |

### First-Time Setup

**For Open WebUI:**

1. Navigate to <http://localhost:8080>
2. Create your admin account on first visit
3. Configure your AI/LLM backend in Settings
4. Start using the interface!

## 📁 Project Structure

```
ansible-docker-apps/
│
├── 📋 Ansible Configuration
│   ├── ansible.cfg                 # Ansible configuration
│   ├── deploy.yml                  # Main deployment playbook
│   ├── uninstall.yml               # Application removal playbook
│   └── inventory.yml               # Ansible inventory (localhost)
│
├── ⚙️ Configuration & Variables
│   └── group_vars/all/
│       ├── main.yml                # Main config (deployment flags, paths)
│       └── vault/                  # 🔒 Encrypted sensitive data (Ansible Vault)
│
├── 🎭 Application Roles
│   └── roles/
│       ├── common/                 # Shared tasks and configurations
│       ├── excalidraw/             # Excalidraw whiteboard
│       ├── open_webui/             # Open WebUI interface
│       ├── portainer/              # Portainer container management
│       ├── caddy/                  # Caddy reverse proxy
│       └── semaphore/              # Semaphore UI for Ansible/Terraform
│       │
│       └── Each role contains:
│           ├── tasks/
│           │   ├── main.yml        # Deployment tasks
│           │   └── uninstall.yml   # Cleanup tasks
│           ├── vars/main.yml       # Role-specific variables
│           └── templates/          # Configuration templates
│
├── 📚 Documentation
│   └── docs/
│       ├── OPEN_WEBUI_CONFIGURATION.md   # Open WebUI setup guide
│       └── examples/                     # Configuration examples
│
├── 🛠️ Utilities & Scripts
│   ├── pyproject.toml                    # Python project configuration (uv)
│   ├── uv.lock                           # Locked Python dependencies
│   └── requirements.yml                  # Ansible collections
│
├── ☁️ Infrastructure as Code
│   └── terraform/                    # Terraform for GitHub repo management
│       ├── main.tf
│       ├── providers.tf
│       ├── variables.tf
│       └── ...
│
├── 🔧 Development Tools
│   ├── .pre-commit-config.yaml    # Pre-commit hooks configuration
│   ├── .vscode/                   # VSCode workspace settings
│   └── .gitignore
│
└── 📄 Project Files
    ├── README.md                  # This file
    ├── CLAUDE.md                  # Claude Code context
    ├── renovate.json              # Renovate dependency update configuration
    └── LICENSE                    # MIT License
```

### Key Directories Explained

| Directory                 | Purpose                                                            |
| ------------------------- | ------------------------------------------------------------------ |
| `roles/`                | Contains Ansible roles for each application (modular architecture) |
| `group_vars/all/`       | Global configuration variables and deployment settings             |
| `group_vars/all/vault/` | Encrypted secrets (passwords, API keys) using Ansible Vault        |
| `docs/`                 | Detailed documentation and configuration guides                    |
| `scripts/`              | Helper scripts for testing and maintenance                         |
| `terraform/`               | Terraform configurations for managing GitHub infrastructure        |

## 📚 Documentation

- **[Open WebUI Configuration](docs/OPEN_WEBUI_CONFIGURATION.md)** - Detailed configuration options for Open WebUI
- **[Configuration Examples](docs/examples/)** - Example configuration files

## ☁️ GitHub Infrastructure as Code

The project includes Terraform configurations to manage GitHub repositories in the `terraform/` directory:

1. Change to the Terraform directory:

```bash
cd terraform
```

2. Initialize Terraform:

```bash
terraform init
```

3. Deploy the infrastructure:

```bash
terraform apply
```

## 👨‍💻 Development

This project follows best practices for Infrastructure as Code with comprehensive quality checks.

### Pre-commit Hooks

The project uses [pre-commit](https://pre-commit.com/) to ensure code quality. Install hooks after cloning:

```bash
pre-commit install
pre-commit install --hook-type commit-msg
```

### Code Quality Tools

All of these run automatically on commit:

| Tool                               | Purpose                               | Files Checked                 |
| ---------------------------------- | ------------------------------------- | ----------------------------- |
| **🔍 Ansible Lint**          | Enforces Ansible best practices       | `*.yml` playbooks and roles |
| **📝 YAML Lint**             | Validates YAML syntax and formatting  | `*.yml`, `*.yaml`         |
| **🛡️ ShellCheck**          | Identifies issues in shell scripts    | `*.sh`                      |
| **🔧 Terraform fmt**         | Formats Terraform files               | `*.tf`                      |
| **🔧 Terraform validate**    | Validates Terraform syntax            | `*.tf`                      |
| **🔧 TFLint**                | Lints Terraform configurations        | `*.tf`                      |
| **🐍 Flake8**                | Python code linter                    | `*.py`                      |
| **🔐 Vault Check**           | Ensures sensitive files are encrypted | `vault/*`                   |
| **🔒 Gitleaks**              | Detects hardcoded secrets             | All files                     |
| **📋 Commitizen**            | Validates conventional commit messages| Commit messages               |
| **📝 Markdownlint**          | Lints Markdown files                  | `*.md`                      |
| **🔤 Codespell**             | Detects spelling errors               | All files                     |
| **✅ Check TOML**            | Validates TOML syntax                 | `*.toml`                    |
| **✅ Check JSON**            | Validates JSON syntax                 | `*.json`                    |
| **✂️ Trailing Whitespace** | Removes trailing whitespace           | All files                     |
| **📄 EOF Fixer**             | Ensures files end with newline        | All files                     |

### Manual Testing

```bash
# Run pre-commit checks manually
pre-commit run --all-files

# Validate Ansible syntax
ansible-playbook deploy.yml --syntax-check

# Check what would change (dry run)
ansible-playbook deploy.yml --check --diff
```

### Dependency Management (Renovate)

This project uses [Renovate](https://docs.renovatebot.com/) to automatically detect new versions of Docker images, GitHub Actions, Python packages, and Terraform providers.

**How it works:**

- Docker image versions in `roles/*/vars/main.yml` are annotated with `# renovate:` comments
- Renovate scans these annotations and opens Pull Requests when updates are available
- Configuration is in `renovate.json` at the project root

**Example annotation:**

```yaml
# renovate: datasource=docker depName=portainer/portainer-ce
portainer_version: "2.33.6"
```

> **Note:** Images without semver tags (`excalidraw:latest`) are excluded from automatic updates via package rules.

### Adding a New Application

1. Create a new role in `roles/<app_name>/`
2. Define variables in `roles/<app_name>/vars/main.yml`
3. Create deployment tasks in `roles/<app_name>/tasks/main.yml`
4. Create uninstall tasks in `roles/<app_name>/tasks/uninstall.yml`
5. Add role to `deploy.yml` with appropriate conditions and tags
6. Add uninstall task to `uninstall.yml`
7. Update documentation

Example role structure:

```
roles/myapp/
├── tasks/
│   ├── main.yml        # Deployment logic
│   └── uninstall.yml   # Cleanup logic
├── vars/
│   └── main.yml        # App-specific variables
└── templates/
    └── config.yml.j2   # Configuration templates (if needed)
```

## 🚨 Troubleshooting

### Common Issues

<details>
<summary><b>Docker Permission Denied</b></summary>

**Problem:** `permission denied while trying to connect to the Docker daemon socket`

**Solution:**

```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and back in for changes to take effect
# Or use: newgrp docker

# Verify
docker ps
```

</details>

<details>
<summary><b>Ansible Vault Password Error</b></summary>

**Problem:** `ERROR! Attempting to decrypt but no vault secrets found`

**Solution:**

```bash
# Ensure pass is installed and configured
pass --version

# Verify the vault password exists in pass
pass show ansible/vault

# If missing, add it
pass insert ansible/vault

# Verify the wrapper script exists and is executable
ls -la scripts/ansible-vault-pass.sh
chmod +x scripts/ansible-vault-pass.sh

# Verify path in ansible.cfg
grep vault_password_file ansible.cfg
```

</details>

<details>
<summary><b>Port Already in Use</b></summary>

**Problem:** `Error: bind: address already in use`

**Solution:**

```bash
# Find what's using the port (example for port 8080)
sudo lsof -i :8080
# or
sudo netstat -tulpn | grep :8080

# Option 1: Stop the conflicting service
# Option 2: Change port in roles/<app>/vars/main.yml
# Example: open_webui_port: 8081

# Redeploy
ansible-playbook deploy.yml --tags "open_webui"
```

</details>

<details>
<summary><b>Pre-commit Hooks Failing</b></summary>

**Problem:** Pre-commit hooks prevent commits

**Solution:**

```bash
# Run pre-commit manually to see errors
pre-commit run --all-files

# Update hooks to latest version
pre-commit autoupdate

# If you need to skip hooks temporarily (not recommended)
git commit --no-verify -m "message"
```

</details>

### Getting Help

If you encounter issues not covered here:

1. **Check the logs:**

   ```bash
   # Ansible output
   ansible-playbook deploy.yml -vvv

   # Docker container logs
   docker logs <container_name>
   ```

2. **Search existing issues:** [GitHub Issues](https://github.com/xgueret/ansible-docker-apps/issues)
3. **Create a new issue:** Provide details about your environment, error messages, and steps to reproduce

## 🤝 Contributing

Contributions are **welcome and appreciated!** This project benefits from community involvement.

### How to Contribute

1. **Fork the repository**

   ```bash
   # Click "Fork" on GitHub, then:
   git clone https://github.com/YOUR-USERNAME/ansible-docker-apps.git
   cd ansible-docker-apps
   ```

2. **Create a feature branch**

   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make your changes**

   - Add a new application role
   - Improve documentation
   - Fix bugs
   - Enhance existing features
4. **Test your changes**

   ```bash
   # Run pre-commit checks
   pre-commit run --all-files

   # Test deployment
   ansible-playbook deploy.yml --check
   ```

5. **Commit your changes**

   ```bash
   git add .
   git commit -m "feat: add amazing feature"
   ```

   Follow [Conventional Commits](https://www.conventionalcommits.org/) format:

   - `feat:` - New features
   - `fix:` - Bug fixes
   - `docs:` - Documentation changes
   - `refactor:` - Code refactoring
   - `test:` - Adding tests
   - `chore:` - Maintenance tasks
6. **Push and create Pull Request**

   ```bash
   git push origin feature/amazing-feature
   ```

   Then create a Pull Request on GitHub

### Contribution Ideas

- 📦 Add new application roles (Grafana, Prometheus, etc.)
- 📚 Improve documentation
- 🐛 Fix bugs or improve error handling
- ✨ Enhance existing features
- 🧪 Add tests
- 🎨 Improve UI/UX of configurations

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community

## 👥 Author

<div align="center">

**Xavier GUERET**

[![GitHub](https://img.shields.io/badge/GitHub-xgueret-181717?style=for-the-badge&logo=github)](https://github.com/xgueret)
[![Twitter](https://img.shields.io/badge/Twitter-@hixmaster-1DA1F2?style=for-the-badge&logo=twitter)](https://x.com/hixmaster)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/xavier-gueret-47bb3019b/)

</div>

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### What this means

- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use
- ⚠️ No liability
- ⚠️ No warranty

---

<div align="center">

**⭐ If this project helped you, please consider giving it a star! ⭐**

</div>
