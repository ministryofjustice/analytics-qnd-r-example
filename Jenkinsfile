node {
    def deploy_dir = "./deploy"
    def app_name = "$(tr [A-Z] [a-z] <<< ${env.JOB_NAME:0:15} | tr '_ ' '-')"

    stage 'Checkout' {
        git "https://github.com/ministryofjustice/analytics-qnd-r-example"
    }

    // stage("Build") {
    //     def Img = docker.build "kerin/analytics-qnd-r-example:latest"
    // }

    stage 'Prepare' {
        sh('sudo apt-get install -y gettext')
    }

    stage 'Test' {
        sh("echo \"app_name: ${app_name}\"")
    }

    // stage 'Deploy' {
    //     sh("mkdir build")
    //     sh("for f in ${deploy_dir}/*.y*ml; do envsubst < $f > build/$(basename $f); done")
    //     sh("kubectl apply -f build/")
    //     sh("kubectl rollout status deployment/${APP_NAME}")
    // }
}
