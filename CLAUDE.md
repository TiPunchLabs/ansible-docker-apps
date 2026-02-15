# CLAUDE.md

Ce fichier fournit le contexte necessaire pour travailler sur ce projet.

## Description

**ansible-docker-apps** est une solution d'Infrastructure as Code pour deployer des applications auto-hebergees via Docker. Le projet utilise Ansible comme orchestrateur pour gerer le cycle de vie des conteneurs (deploiement, configuration, desinstallation).

**Objectif** : Simplifier le deploiement d'applications conteneurisees (Open WebUI, Excalidraw, Portainer, Caddy) avec une approche declarative et reproductible.

## Stack technique

- **Ansible** : Orchestration et gestion du cycle de vie des applications
- **Docker** : Conteneurisation des applications
- **Terraform** : Gestion du repo GitHub (dossier `terraform/`)
- **Python/uv** : Runtime Ansible avec gestion des dependances via uv
- **Ansible Vault + pass** : Chiffrement des secrets avec password manager

## Structure du projet

```text
ansible-docker-apps/
├── deploy.yml              # Playbook principal de deploiement
├── uninstall.yml           # Playbook de desinstallation
├── inventory.yml           # Inventaire (localhost)
├── ansible.cfg             # Configuration Ansible
├── pyproject.toml          # Configuration Python (uv)
├── group_vars/all/
│   ├── main.yml            # Variables globales
│   └── vault/              # Secrets chiffres (Ansible Vault)
├── roles/
│   ├── common/             # Taches partagees
│   ├── excalidraw/         # Application Excalidraw
│   ├── open_webui/         # Interface Open WebUI
│   ├── portainer/          # Gestion des conteneurs
│   └── caddy/              # Reverse proxy
├── docs/                   # Documentation
├── terraform/              # Terraform pour GitHub
└── .claude/commands/       # Commandes Claude
```

## Commandes importantes

```bash
# Installation des dependances
uv sync
ansible-galaxy collection install -r requirements.yml

# Deploiement
ansible-playbook deploy.yml                    # Deployer tout
ansible-playbook deploy.yml --tags "open_webui" # Deployer un role specifique
ansible-playbook deploy.yml --tags "caddy"      # Deployer Caddy

# Desinstallation
ansible-playbook uninstall.yml --tags "caddy"   # Desinstaller un role

# Validation
ansible-playbook deploy.yml --syntax-check      # Verifier syntaxe
ansible-playbook deploy.yml --check --diff      # Dry run

# Qualite
pre-commit run --all-files                      # Lancer tous les linters

# Vault
ansible-vault encrypt group_vars/all/vault/file.yml
ansible-vault decrypt group_vars/all/vault/file.yml
ansible-vault edit group_vars/all/vault/file.yml
```

## Conventions

### Structure d'un role

```text
roles/<role_name>/
├── tasks/
│   ├── main.yml            # Deploiement
│   └── uninstall.yml       # Desinstallation
├── vars/
│   └── main.yml            # Variables du role
├── templates/              # Templates Jinja2
├── handlers/               # Handlers (optionnel)
└── defaults/               # Valeurs par defaut (optionnel)
```

### Nommage des variables

- Prefixer par le nom du role : `open_webui_port`, `caddy_version`
- Secrets dans `group_vars/all/vault/` uniquement
- Pas de valeurs sensibles en clair dans le code

### Types de commit (Conventional Commits)

```text
feat(role): nouvelle fonctionnalite
fix(role): correction de bug
infra: changement d'infrastructure
config: modification de configuration
docs: documentation
chore: maintenance
security: correctif de securite
```

## Ce qu'on FAIT

- Utiliser les FQCN (Fully Qualified Collection Names) : `ansible.builtin.file`
- Chiffrer tous les secrets avec Ansible Vault
- Creer un `uninstall.yml` pour chaque role
- Documenter les variables dans `vars/main.yml`
- Utiliser des handlers pour les redemarrages
- Tester avec `--check --diff` avant d'appliquer
- Valider avec `pre-commit run --all-files` avant de commiter

## Ce qu'on NE FAIT PAS

- Commiter des fichiers vault non chiffres
- Utiliser `command`/`shell` quand un module Ansible existe
- Hardcoder des valeurs sensibles
- Deployer sans avoir teste en mode check
- Modifier directement les conteneurs (tout passe par Ansible)

## Applications disponibles

| Application | Version | Port   | Description                    |
|-------------|---------|--------|--------------------------------|
| Open WebUI  | v0.7.2  | 8080   | Interface web pour LLM         |
| Excalidraw  | latest  | 8082   | Tableau blanc collaboratif     |
| Portainer   | 2.33.6  | 9443   | Gestion des conteneurs Docker  |
| Caddy       | 2.11-alpine | 80/443 | Reverse proxy avec auto HTTPS  |
| Semaphore   | v2.17.2 | 3000   | UI pour Ansible/Terraform      |

## Fichiers de configuration

- `ansible.cfg` : Configuration Ansible (vault, inventory, etc.)
- `pyproject.toml` : Dependances Python (uv)
- `.pre-commit-config.yaml` : Hooks de qualite organises par categorie
- `.yamllint` : Configuration yamllint
- `.ansible-lint` : Configuration ansible-lint
- `.markdownlint.json` : Configuration markdownlint
- `renovate.json` : Configuration Renovate (gestion automatique des versions)

## Pre-commit hooks

| Categorie | Hooks |
|-----------|-------|
| General | end-of-file-fixer, trailing-whitespace, check-yaml, check-toml, check-json |
| Security | gitleaks, detect-private-key, check-ansible-vault |
| Commit | commitizen (conventional commits) |
| Shell | shfmt, shellcheck |
| YAML/Ansible | ansible-lint, yamllint |
| Terraform | terraform_fmt, terraform_validate, terraform_tflint |
| Python | flake8 |
| Markdown | markdownlint |
| Spelling | codespell |

## Vault

Le mot de passe vault est gere via `pass` (password manager) :

- Script wrapper : `./scripts/ansible-vault-pass.sh`
- Cle pass : `ansible/vault`

Pour verifier qu'un fichier est chiffre :

```bash
head -1 group_vars/all/vault/file.yml
# Doit afficher : $ANSIBLE_VAULT;1.1;AES256
```

## Terraform (GitHub)

Configuration dans `terraform/` pour gerer le repository GitHub :

- Provider : `integrations/github` v6.10.2
- Variables : `github_token`, `github_owner`, `repository_name`
- Documentation : <https://registry.terraform.io/providers/integrations/github/latest>
