# Windows Search Indexing Troubleshooting

## Issue

Windows Search reported that indexing was turned off and search results were not behaving normally.

## Symptoms

- Windows Search showed an indexing warning
- Search results were incomplete or unavailable
- The Windows Search service was not running

## Troubleshooting Steps

### 1. Check the Windows Search service

Use:

```powershell
Get-Service WSearch
```

If the service is stopped, that can prevent normal indexing and search behavior.

### 2. Start the Windows Search service

Use:

```powershell
Start-Service WSearch
```

### 3. Configure the service to start automatically

Use:

```powershell
Set-Service WSearch -StartupType Automatic
```

### 4. Verify service status

Use:

```powershell
Get-Service WSearch
```

Confirm that the service status shows `Running`.

### 5. Rebuild the search index

Open **Indexing Options** in Windows and use the advanced options to rebuild the search index.

This allows Windows to recreate the index after the service has been restored.

### 6. Verify search behavior

Use Windows Search to confirm that applications and files appear normally and that the indexing warning is no longer displayed.

## Root Cause

The Windows Search service was stopped, preventing normal search indexing.

## Resolution

The Windows Search service was restarted, configured to start automatically, and the search index was rebuilt.

## Verification

After the fix:

- `WSearch` was running
- Windows Search no longer showed the indexing warning
- Normal search results returned

## Skills Demonstrated

- Windows service troubleshooting
- PowerShell service management
- Windows Search
- Indexing Options
- Root-cause analysis
- Post-resolution validation
