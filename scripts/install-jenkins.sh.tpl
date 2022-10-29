#!/bin/bash



yum update -y
yum install wget -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y

mkdir -p /var/lib/jenkins/init.groovy.d/

cat > /var/lib/jenkins/jenkins.install.UpgradeWizard.state << EOF
2.0
EOF
cat > /var/lib/jenkins/init.groovy.d/basic-security.groovy << EOF
#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

println "Creating local user 'admin'"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('admin','${jenkins_admin_password}')
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()
EOF
chown -R jenkins:jenkins /var/lib/jenkins/

systemctl enable jenkins
systemctl start jenkins

