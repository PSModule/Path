﻿function Add-EnvPath {
    <#
        .SYNOPSIS
        Adds a path to the PATH environment variable.

        .DESCRIPTION
        Adds a path to the PATH environment variable for the current session and optionally for the machine or user.

        .EXAMPLE
        Add-EnvPath -Path 'C:\Program Files\Git\cmd'

        Adds 'C:\Program Files\Git\cmd' to the PATH environment variable for the current session.

        .EXAMPLE
        Add-EnvPath -Path 'C:\Program Files\Git\cmd' -Container Machine

        Adds 'C:\Program Files\Git\cmd' to the PATH environment variable for the machine.

    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User    = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -notcontains $Path) {
            $persistedPaths = $persistedPaths + $Path | Where-Object { $_ }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | Where-Object { $_ }
        $env:Path = $envPaths -join ';'
    }
}
