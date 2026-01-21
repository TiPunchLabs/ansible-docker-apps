# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| latest  | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please:

1. **Do not** open a public issue
2. Email the maintainers directly
3. Include details about the vulnerability
4. Allow time for a fix before public disclosure

We take security seriously and will respond promptly.

## Security Best Practices

This project follows security best practices:

- **Ansible Vault**: All sensitive data (passwords, API keys) is encrypted
- **No hardcoded secrets**: Secrets are never committed in plain text
- **.gitignore**: Sensitive files are excluded from version control
- **Pre-commit hooks**: Security checks run before each commit

## Vault Password Management

The vault password should be:

- Stored securely (e.g., using `pass`, a password manager)
- Never committed to the repository
- Rotated periodically
