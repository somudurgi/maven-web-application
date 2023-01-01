//Pipleline Project - Scripted Way
node{

//Command for job specific properties(build-periodically)
//properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '3', numToKeepStr: '3')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([cron('* * * * *')])])

//Command for job specific properties(poll-SCM)
//properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '3', numToKeepStr: '3')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])

//defining variable for Maven tool to use Maven 3.8.6 installed in Global Tool Configuration
def mavenTool = tool name: "Maven 3.8.6"

//stage for getting code from GitHub
stage('CheckOutCode'){
git branch: 'development', credentialsId: '07bb55e8-292f-48f9-bffe-1371dff92ea6', url: 'https://github.com/somudurgi/maven-web-application.git'
}

//stage for creating packages/artifacts
stage('MavenBuild'){
sh "${mavenTool}/bin/mvn clean package"
}

//stage for gnerating SonarQube Reports
stage('GenerateSonarQubeReports'){
sh "${mavenTool}/bin/mvn sonar:sonar"
}

//stage for uploading artifacts to Nexus Reports
stage('UploadArtifactsToNexusRepo'){
sh "${mavenTool}/bin/mvn deploy"
}

//stage for deploying war file to Tomcat Server
stage('DeployAppToTomcat'){
//command for connecting jenkins to tomcat server
sshagent(['253a3196-9f96-47eb-8e62-05898b7e2a1f']) {
//copying war file from jenkins to tomcat server
sh "scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/Pipeline-Scripted_Way1/target/maven-web-application.war ec2-user@172.31.41.128:/opt/apache-tomcat-9.0.70/webapps/"

}

}

}
