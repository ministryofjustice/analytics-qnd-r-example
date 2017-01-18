node {
    def deploy_dir = "./deploy"
    def app_name = sh "echo ${env.JOB_NAME} | tr '[:upper:]' '[:lower:]' | tr -s '_ ' '-' |cut -c1-15"

    stage('Checkout') {
        git "https://github.com/ministryofjustice/analytics-qnd-r-example"
    }

    // stage("Build") {
    //     def Img = docker.build "kerin/analytics-qnd-r-example:latest"
    // }

    // stage('Prepare') {
    //     sh('apt-get install -y gettext')
    // }

    stage('Test') {
        echo "${app_name}"
        sh "/usr/local/bin/kubectl get pods"
    }

    // stage 'Deploy' {
    //     sh("mkdir build")
    //     sh("for f in ${deploy_dir}/*.y*ml; do envsubst < $f > build/$(basename $f); done")
    //     sh("kubectl apply -f build/")
    //     sh("kubectl rollout status deployment/${APP_NAME}")
    // }
}
