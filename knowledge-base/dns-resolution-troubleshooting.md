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
```

If this succeeds, the device still has network connectivity.

### 2. Test DNS resolution separately

Use:

```powershell
Resolve-DnsName microsoft.com
```

If this fails while direct IP connectivity works, the issue is likely related to DNS rather than the network adapter or general internet connectivity.

### 3. Check current DNS configuration

Use:

```powershell
Get-DnsClientServerAddress
```

Review the configured DNS servers and confirm they are valid for the environment.

### 4. Restore DNS configuration

Return the adapter to the correct DNS configuration.

If the environment uses automatic DNS assignment, restore the normal adapter settings.

### 5. Clear cached DNS information

Use:

```powershell
Clear-DnsClientCache
```

### 6. Verify resolution

Test again:

```powershell
Resolve-DnsName microsoft.com
```

Then confirm general connectivity:

```powershell
Test-Connection microsoft.com
```

## Root Cause

The endpoint was configured with an invalid DNS server, which caused hostname resolution to fail while basic IP connectivity remained available.

## Resolution

The correct DNS configuration was restored and normal hostname resolution returned.

## Verification

After the fix:

- DNS queries completed successfully
- Hostnames resolved normally
- Internet connectivity remained available

## Skills Demonstrated

- DNS troubleshooting
- TCP/IP troubleshooting
- PowerShell
- Root-cause isolation
- Network configuration
- Post-resolution validation
