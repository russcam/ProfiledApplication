

New-Module -Name ElasticApmProfiler -Scriptblock {
function Set-ProfilerEnvironmentVariables {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ProfilerDirectory,

        [Parameter()]
        [string]
        [ValidateSet('trace', 'debug', 'info', 'warn', 'error', 'none')]
        $LogLevel = 'warn'
    )

    [Environment]::SetEnvironmentVariable("COR_PROFILER", "{FA65FE15-F085-4681-9B20-95E04F6C03CC}", "Machine")
    [Environment]::SetEnvironmentVariable("COR_ENABLE_PROFILING", "1", "Machine")
    [Environment]::SetEnvironmentVariable("COR_PROFILER_PATH", "$ProfilerDirectory\elastic_apm_profiler.dll", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_HOME", "$ProfilerDirectory", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_INTEGRATIONS", "$ProfilerDirectory\integrations.yml", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_LOG_DIR", "$ProfilerDirectory\logs", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_LOG", $LogLevel, "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_EXCLUDE_PROCESSES", "devenv.exe;Microsoft.ServiceHub.Controller.exe;ServiceHub.Host.CLR.exe;ServiceHub.TestWindowStoreHost.exe;ServiceHub.DataWarehouseHost.exe;sqlservr.exe;VBCSCompiler.exe;iisexpresstray.exe;msvsmon.exe", "Machine")
    [Environment]::SetEnvironmentVariable("COMPlus_LoaderOptimization", "1", "Machine")
}

function Remove-ProfilerEnvironmentVariables {
    [CmdletBinding()]
    param ()

    [Environment]::SetEnvironmentVariable("COR_PROFILER", "", "Machine")
    [Environment]::SetEnvironmentVariable("COR_ENABLE_PROFILING", "", "Machine")
    [Environment]::SetEnvironmentVariable("COR_PROFILER_PATH", "", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_HOME", "", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_INTEGRATIONS", "", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_LOG_DIR", "", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_LOG", "", "Machine")
    [Environment]::SetEnvironmentVariable("ELASTIC_APM_PROFILER_EXCLUDE_PROCESSES", "", "Machine")
    [Environment]::SetEnvironmentVariable("COMPlus_LoaderOptimization", "", "Machine")
}

Export-ModuleMember -Function Set-ProfilerEnvironmentVariables,Remove-ProfilerEnvironmentVariables

}

