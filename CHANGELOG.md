# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- **Semaphore role** - Modern UI for Ansible, Terraform and other DevOps tools
  - PostgreSQL database backend with health checks
  - Docker Compose template with multi-service configuration
  - Secure credentials stored in Ansible Vault
  - Caddy reverse proxy integration (semaphore.local)
- **Caddy role** - Reverse proxy with automatic HTTPS support
  - Docker Compose template with host network mode
  - Caddyfile template with Jinja2 variables
  - Handlers for configuration reload
  - Sensitive backend IPs stored in Ansible Vault
- **Portainer role** - Container management platform (port 9443)
- **New pre-commit hooks** for improved code quality:
  - `gitleaks` - Secret detection in code
  - `commitizen` - Conventional commit message validation
  - `markdownlint` - Markdown file linting
  - `codespell` - Spelling error detection
  - `check-toml` - TOML file validation
  - `check-json` - JSON file validation
- `.markdownlint.json` configuration file
- UV support for Python dependency management
- `scripts/ansible-vault-pass.sh` for secure vault password retrieval via `pass`
- Open source documentation (CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md)
- GitHub issue and PR templates
- CI workflow for automated linting

### Changed

- **Pre-commit configuration** reorganized by category (General, Security, Shell, YAML/Ansible, Terraform, Python, Markdown, Spelling)
- **Ansible-lint hook** now uses local installation via `uv run` for better compatibility
- **Terraform provider** updated to GitHub provider 6.10.2 with `owner` configuration
- **Variables naming** - `repository_owner` renamed to `github_owner` for consistency
- Migrated from `requirements.txt` to `pyproject.toml` with UV
- Updated `.envrc` for UV virtual environment management
- Documentation updated with `pass` integration for vault password management

### Fixed

- Ansible-lint compatibility issues with pre-commit
- Missing `---` document start in `.github/dependabot.yml` and `.github/workflows/ci.yml`
- Variable naming convention in `roles/common/tasks/docker_app.yml` (`compose_output` -> `common_compose_output`)
- Terraform GitHub provider 403 error by adding `owner` to provider configuration

### Removed

- Deprecated roles (homer, ollama, planka, postgres)
- Orphan configuration files for removed roles
- `requirements.txt` (replaced by `pyproject.toml`)

## [0.1.0] - Initial Release

### Added

- Excalidraw deployment role
- Open WebUI deployment role
- Common role for shared configurations
- Ansible Vault integration for secrets
- Pre-commit hooks (ansible-lint, yamllint, shellcheck, terraform)
- Terraform configuration for GitHub repository management
