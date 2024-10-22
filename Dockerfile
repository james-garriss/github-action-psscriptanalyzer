FROM mcr.microsoft.com/powershell:lts-ubuntu-22.04 as base
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module PSScriptAnalyzer -RequiredVersion 1.23.0 -Scope AllUsers -Repository PSGallery

FROM base as analyzer
LABEL "com.github.actions.name"         = "PSScriptAnalyzer"
LABEL "com.github.actions.description"  = "Run PSScriptAnalyzer tests"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="green"

LABEL "name"       = "github-action-psscriptanalyzer"
LABEL "version"    = "0.0.1"
LABEL "repository" = "https://github.com/james-garriss/github-action-psscriptanalyzer"
LABEL "homepage"   = "https://github.com/PowerShell/PSScriptAnalyzer"
LABEL "maintainer" = "James Garriss <jgarriss@mitre.org>"

ADD entrypoint.ps1  /entrypoint.ps1

COPY LICENSE README.md /

RUN chmod +x /entrypoint.ps1

ENTRYPOINT ["pwsh", "/entrypoint.ps1"]
