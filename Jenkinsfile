node {
    def DEPLOY_DIR = "./deploy"
    def APP_NAME = sh(
        script: "echo ${env.JOB_NAME} | tr '[:upper:]' '[:lower:]' | tr -s '_ ' '-' |cut -c1-15",
        returnStdout: true
    ).trim()

    stage ('Checkout') {
        checkout scm

        // Incredibly, Jenkins Pipeline scripts do not get passed git variables,
        // so they're handled manually here.
        //
        // Declaring vars as env.FOO makes them available in another stage/scope
        def env.GIT_SHA = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        def env.GIT_URL = sh(returnStdout: true, script: 'git config --get remote.origin.url').trim()
    }

    stage ('Build') {
        sh "mkdir build"

        // replace variable placeholders in k8s YML files with values
        // BASE_APP_HOST is provided by EnvInject in Job config
        sh """
        for f in ${DEPLOY_DIR}/*.y*ml
        do
            sed -e 's|\${APP_NAME}|'${APP_NAME}'|g' \
                -e 's|\${GIT_SHA}|'${env.GIT_SHA}'|g' \
                -e 's|\${GIT_URL}|'${env.GIT_URL}'|g' \
                -e 's|\${BASE_APP_HOST}|'${env.BASE_APP_HOST}'|g' \
                \$f > build/\$(basename \$f)
        done
        """
    }

    stage ('Deploy') {
        sh "kubectl apply -f build/"
        sh "kubectl rollout status deployment/${APP_NAME}"
    }
}
