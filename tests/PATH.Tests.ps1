﻿[CmdletBinding()]
Param(
    # Path to the module to test.
    [Parameter()]
    [string] $Path
)

Write-Verbose "Path to the module: [$Path]" -Verbose

Describe 'PATH' {
    Context 'Module' {
        It 'The module should be available' {
            Get-Module -Name 'PATH' -ListAvailable | Should -Not -BeNullOrEmpty
            Write-Verbose (Get-Module -Name 'PATH' -ListAvailable | Out-String) -Verbose
        }
        It 'The module should be imported' {
            { Import-Module -Name 'PATH' -Verbose -RequiredVersion 999.0.0 -Force } | Should -Not -Throw
        }
    }

    Context 'Function: Get-EnvironemntPath' {
        It 'Should not throw' {
            $result = Get-EnvironmentPath
            Write-Verbose ($result | Out-String) -Verbose
            $result | Should -BeOfType [System.String]
        }

        It "Should not throw when using '-AsArray'" {
            $result = Get-EnvironmentPath -AsArray
            Write-Verbose ($result | Out-String) -Verbose
            Should -ActualValue $result -BeOfType [System.String[]]
        }
    }

    Context 'Function: Add-EnvironmentPath' {
        It 'Should not throw' {
            {
                Add-EnvironmentPath -Path $HOME -Verbose
                Write-Verbose (Get-EnvironmentPath | Out-String) -Verbose
                Write-Verbose (Get-EnvironmentPath -AsArray | Out-String) -Verbose
            } | Should -Not -Throw
        }
    }

    Context 'Function: Repair-EnvironmentPath' {
        It 'Should not throw' {
            {
                Repair-EnvironmentPath -Verbose
                Write-Verbose (Get-EnvironmentPath | Out-String) -Verbose
                Write-Verbose (Get-EnvironmentPath -AsArray | Out-String) -Verbose
            } | Should -Not -Throw
        }
    }

    Context 'Function: Remove-EnvironmentPath' {
        It 'Should not throw' {
            {
                Remove-EnvironmentPath -Path $HOME -Verbose
                Write-Verbose (Get-EnvironmentPath | Out-String) -Verbose
                Write-Verbose (Get-EnvironmentPath -AsArray | Out-String) -Verbose
            } | Should -Not -Throw
        }
    }
}
