# Github Action PSSscriptAnalyzer

This repo creates a [GitHub action](https://github.com/features/actions) to run [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) static code analysis checks on PowerShell for [Pull Requests](https://help.github.com/articles/about-pull-requests/).

It was forked from [this outdated repo](https://github.com/devblackops/github-action-psscriptanalyzer).  I have simply updated the software versions and cleaned up the output a bit.  

## Success Criteria

By default, this action will succeed if **zero** PSScriptAnalyzer **errors** and **warnings** are found. Failing on errors, warnings, or informational issues can be configured. See [Usage](#Usage) below. The sending of comments back to the PR if the action fails can be disabled if desired.

## Usage

### Basic

This basic configuration will run PSSA and fail on errors or warnings and send a comment back to the PR with a summary.  `repoToken` is required for sending comments back.

```yaml
name: CI
on: [pull_request]
jobs:
  lint:
    name: Run PSSA
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: lint
      uses: james-garriss/github-action-psscriptanalyzer@master
      with:
        repoToken: ${{ secrets.GITHUB_TOKEN }}
```

### Advanced

This advanced configuration that will run PSSA only in the `MyModule` directory, with custom PSSA settings and fail on errors, warnings, or informational issues.
A comment back to the PR with the PSSA summary will also be sent if any issues were detected.

```yaml
name: CI
on: [pull_request]
jobs:
  lint:
    name: Run PSSA
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: lint
      uses: james-garriss/github-action-psscriptanalyzer@master
      with:
        rootPath: MyModule
        settingsPath: pssa_settings.psd1
        sendComment: true
        repoToken: ${{ secrets.GITHUB_TOKEN }}
        failOnErrors: true
        failOnWarnings: true
        failOnInfos: true
```

## Inputs

| Name           | Default  | Description |
|----------------|----------|-------------|
| rootPath       | \<none>  | The root directory to run PSScriptAnalyzer on. By default, this is the root of the repository.
| settingsPath   | \<none>  | The path to a PSScriptAnalyser settings file to control rules to execute.
| sendComment    | true     | Enable/disable sending comments with PSScriptAnalyzer results back to PR.
| repoToken      | \<none>  | GitHub token the action will use to send comments back to PR with. Use `${{ secrets.GITHUB_TOKEN }}`.
| failOnErrors   | true     | Enable/disable failing the action on PSScriptAnalyzer error items.
| failOnWarnings | true     | Enable/disable failing the action on PSScriptAnalyzer warning items.
| failOnInfos    | false    | Enable/disable failing the action on PSScriptAnalyzer informational items.
