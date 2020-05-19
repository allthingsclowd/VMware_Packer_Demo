# HashiCorp Packer - Image Building for Continuous Delivery Pipelines

_"Which came first the chicken or Packer?"_

The correct answer is possibly Vagrant...but I built this Vagrant based Virtual Box Image using Packer!

Vagrant is HashiCorp's answer for creating powerful developer enabling environments that can be captured as code - a configuration file - and is thus reproduceable.

This enables a consistent day one experience for new team members that join your organisation. Once they have the same vagrant file (build environment description in code) they can replicate the developer experience of the existing developers rapidly. No more 'works on my machine' challenges, within reason.

Operations teams can also leverage Vagrant for testing and reproducing many day-to-day activities that don't always need physical hardware to validate a software process - e.g. patch a system (for traditional mindset), backup and recovery etc. 

## Goal

The purpose of this repo is actually to illustrate how Packer can be used to create an image which includes testing and is all defined through Infrastructure as Code.

Two images are created :

1. An Ubuntu 20.04 LTS Virtualbox Image for use on a developer laptop or desktop - used by Vagrant
2. An Ubuntu 20.04 LTS VMware Image to deploy on a server - used by Terraform

Vagrant is typically used during early development lifecycles.
Terraform is quickly becoming the standard tooling for deploying production grade infrastructure.

The same Packer Image Definition, template, is used here to illustrate how the same image is built and tested in the deployment workflow guaranting consistency between development and production environments.

![image](https://user-images.githubusercontent.com/9472095/54200937-bd369980-44cc-11e9-8149-d6b628d629ef.png)

## Prerequisites

To utilise this repo and start to learn about Packer, Vagrant and Terraform it's worth setting up the following pre-requisites which many IT Operations folks are not very familiar with but these are table-stakes for the modern Infrastructure Workflow:

1. [Optional - Learn about git](https://www.atlassian.com/git/tutorials/what-is-version-control) - only the basics required but you can follow the instructions blindly below if that's all you need.

2. [Setup a Github account](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home) (if you already have GitLab or BitBucket that's great too)

3. [Get yourself a set of SSH Keys - No Passwords Allowed](https://www.atlassian.com/git/tutorials/git-ssh)

4. [Configure SSH on your github account](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)

5. [TRY NOT TO COMMIT YOUR SECRET DATA TO GIT](https://www.google.com/search?q=how+to+avoid+committing+passwords+to+git&oq=how+to+avoid+committing+passwords+to+git&aqs=chrome..69i57j33.9415j0j7&sourceid=chrome&ie=UTF-8) I make this mistake about twice a month, with my demo accounts, so I am well practised at rotating my credentials and certificates. Practise rotation of your secrets BEFORE you have to. When playing in the cloud space get used to working with Environment Variables rather than storing any secrets within your repo. Ideally you'd have an environment variable set by an OS keychain. In reality I keep my secrets in a secure file located outside the repo and use this file to configure the environment variables.

6. [Optional - Setup a VagrantCloud account](https://app.vagrantup.com/) This will be used to upload your vagrant images should you wish to share them with the rest of the world

7. A host system (1xCPU & 8GB RAM more is better) to work with this repository - Ubuntu 18.04 LTS is good, I use a MacBook with the latest OSX 13.X.

8. [Optional] Access to VMware vCenter and an ESX Server if you wish to build and deploy VMware Images. Yes, I'm the sad sort of individual that has this physical setup at home but the assumption is that you may need to do this in work.

9. Install git, virtualbox and let's go......

## Instructions

wip...To BE CONTINUED add links to the official training up top....