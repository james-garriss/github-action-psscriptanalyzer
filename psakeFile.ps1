[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '')]
param()

task default -depends Build

task Init {
    $script:dockerAcct = 'jamesgarriss'
    $script:imageName  = $env:BHProjectName
    $script:dockerRepo = "$dockerAcct/$imageName"
    $script:version    = '0.0.1'
}

task Build -depends Init {
    "Building [$script:version]"
    exec {
        docker build -t "$dockerRepo`:$version" .
    }
}

task Login {
    exec {
        docker login
    }
}

task Push -depends Build, Login {
    exec {
        docker push "$dockerRepo`:$version"
    }
}

task ? {
    'Available tasks:'
    $psake.context.Peek().Tasks.Keys | Sort-Object
}
