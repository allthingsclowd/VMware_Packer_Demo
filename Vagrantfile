# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    #override global variables to fit Vagrant setup
    ENV['DEMO_IP']||="192.168.99.10"
    ENV['DEMO_NAME']||="packer-example"
    
    #global config
    config.vm.synced_folder ".", "/usr/local/bootstrap"
    config.vm.box = "allthingscloud/packer-example-image"
    #config.vm.box_version = "0.0.1589186248"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
    end

    config.vm.define "example" do |demo|
        demo.vm.hostname = ENV['DEMO_NAME']
        demo.vm.network "private_network", ip: ENV['DEMO_IP']

    end



end