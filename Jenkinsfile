node {
    def DEPLOY_DIR = "./deploy"
    def APP_NAME = sh(
        script: "echo ${env.JOB_NAME} | tr '[:upper:]' '[:lower:]' | tr -s '_ ' '-' |cut -c1-15",
        returnStdout: true
    ).trim()

    stage('Checkout') {
        // git "https://github.com/ministryofjustice/analytics-qnd-r-example"
        checkout scm
    }

    // stage("Build") {
    //     def Img = docker.build "kerin/analytics-qnd-r-example:latest"
    // }

    // stage('Prepare') {
    //     sh('apt-get install -y gettext')
    // }

    // stage('Test') {
    //     echo "${APP_NAME}"
    //     sh "/usr/local/bin/kubectl get pods"
    // }

    stage ('Build') {
        sh "mkdir build"
        sh "for f in ${DEPLOY_DIR}/*.y*ml; do envsubst < $f > build/$(basename $f); done"
    }

    stage ('Deploy') {
        sh "kubectl apply -f build/"
        sh "kubectl rollout status deployment/${APP_NAME}"
    }

    // stage 'Deploy' {
    //     sh("mkdir build")
    //     sh("for f in ${deploy_dir}/*.y*ml; do envsubst < $f > build/$(basename $f); done")
    //     sh("kubectl apply -f build/")
    //     sh("kubectl rollout status deployment/${APP_NAME}")
    // }
}
