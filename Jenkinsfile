node('worker') {
  stage('Checkout') {
    checkout scm
  }

  stage('Mirror') {
    withCredentials([file(credentialsId: 'CDPE_GIT_SSH_KEY', variable: 'CDPE_SSH_KEY')]) {
        sh '''#!/bin/bash
          echo 'ssh -i '"${CDPE_SSH_KEY}"' $*' > ssh
          chmod +x ssh
          export GIT_SSH='./ssh'
          git checkout ${BRANCH_NAME}

          echo 'pushing to gitlab'
          git remote add gitlab git@cdpe-gitlab-test-1.delivery.puppetlabs.net:cdpe_unit_tests/cdpe-2017-3-pe-master-1-control.git || true
          git push gitlab ${BRANCH_NAME} -f

          echo 'pushing to ado'
          git remote add ado git@ssh.dev.azure.com:v3/cd4peAzureDevOpsTest/CD4PE%20Azure%20DevOps%20Test%20Project/cdpe-tests-control-repo || true
          git push ado ${BRANCH_NAME} -f

          echo 'pushing to bitbucket-server'
          git remote add bitbucket ssh://git@cdpe-bitbucket-test-1.delivery.puppetlabs.net:7999/tes/cdpe-2018-1-pe-master-2-control.git || true
          git push bitbucket ${BRANCH_NAME} -f

          echo 'pushing to bitbucket-cloud'
          git remote add bitbucket-cloud git@bitbucket.org:cd4peteam/control-repo.git || true
          git push bitbucket-cloud ${BRANCH_NAME} -f

          echo 'pushing to bitbucket-cloud'
          git remote add github git@github.com:puppet-pipelines-tester/cdpe-2018-1-pe-master-1-control.git || true
          git push github ${BRANCH_NAME} -f

          echo 'pushing to bitbucket-cloud'
          git remote add githubenterprise git@cdpe-github-enterprise-test-1.delivery.puppetlabs.net:RDM-Integration-tests/cdpe-2018-1-pe-master-3-control.git || true
          git push githubenterprise ${BRANCH_NAME} -f
        '''
    }
  }
}
