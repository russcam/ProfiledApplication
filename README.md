# ASP.NET Full Framework profiled application

1. run module.ps1 from a Administrator PowerShell prompt to install module of helper functions
2. run the following from an Administrator PowerShell prompt

    ```powershell
    Set-ProfilerEnvironmentVariables -ProfilerDirectory <profiler-dir>
    ```

    where `<profiler-dir>` is the profiler directory. This sets global environment variables for the profiler. It assumes that APM server is running at `http://localhost:8200`; modify the module.ps1 script to change environment variables as appropriate.
3. Launch Visual Studio and load ProfiledApplication.sln
4. Run ProfiledApplication
5. Open `http://localhost:53379/` in the browser and click on Home, About and Contact links
6. Observe that APM UI captures transactions for the requests
7. Stop ProfiledApplication
8. run the following from an Administrator PowerShell prompt

    ```powershell
    Remove-ProfilerEnvironmentVariables
    ```

    to remove global environment variables