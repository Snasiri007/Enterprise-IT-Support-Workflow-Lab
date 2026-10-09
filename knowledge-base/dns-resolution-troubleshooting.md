# DNS Resolution Troubleshooting

## Issue

The endpoint had working network connectivity but could not resolve hostnames.

## Symptoms

- Direct IP connectivity still worked
- Hostname resolution failed
- DNS queries timed out

## Troubleshooting Steps

### 1. Verify basic connectivity

Use:

```powershell
Test-Connection 8.8.8.8
