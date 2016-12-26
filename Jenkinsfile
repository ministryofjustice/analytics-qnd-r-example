node {
    stage("Checkout") {
        git "git@github.com:kerin/analytics-qnd-r-example.git"
    }

    stage("Build") {
        def Img = docker.build "kerin/analytics-qnd-r-example:latest"
    }
}
