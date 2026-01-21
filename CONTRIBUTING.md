# Contributing to Local Projects

Thank you for your interest in contributing!

## How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `infra:` Infrastructure changes
- `config:` Configuration changes
- `chore:` Maintenance tasks

## Code Style

- Run `pre-commit run --all-files` before committing
- Follow existing code patterns
- Use YAML Lint and Ansible Lint standards

## Adding a New Application

1. Create a new role in `roles/<app_name>/`
2. Add the role structure:

   ```
   roles/<app_name>/
   ├── tasks/
   │   ├── main.yml
   │   └── uninstall.yml
   ├── vars/
   │   └── main.yml
   └── templates/
       └── docker-compose.yml.j2
   ```

3. Add `deploy_<app_name>: false` to `group_vars/all/main.yml`
4. Add the role to `deploy.yml` and `uninstall.yml`
5. Update documentation

## Questions?

Open an issue for any questions or concerns.
