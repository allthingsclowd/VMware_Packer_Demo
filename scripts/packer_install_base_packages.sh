#!/usr/bin/env bash

# TODO: Add checksums to ensure integrity of binaries downloaded

install_binary () {
    
    pushd /usr/local/bin
    [ -f ${1}_${2}_linux_amd64.zip ] || {
        sudo wget -q https://releases.hashicorp.com/${1}/${2}/${1}_${2}_linux_amd64.zip
    }
    sudo unzip -o ${1}_${2}_linux_amd64.zip
    sudo chmod +x ${1}
    sudo rm ${1}_${2}_linux_amd64.zip
    popd
    ${1} --version
}

install_hashicorp_binaries () {

    install_binary packer ${packer_version}
    install_binary vagrant ${vagrant_version}
    install_binary vault ${vault_version}
    install_binary terraform ${terraform_version}
    install_binary consul ${consul_version}
    install_binary nomad ${nomad_version}
    install_binary envconsul ${env_consul_version}
    install_binary consul-template ${consul_template_version}

}

install_chef_inspec () {
    
    [ -f /usr/bin/inspec ] &>/dev/null || {
        pushd /tmp
        curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec   
        popd
        inspec version
    }    

}

install_envoy () {

    pushd /tmp
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -sL 'https://getenvoy.io/gpg' | sudo apt-key add -
    apt-key fingerprint 6FF974DB
    sudo add-apt-repository \
        "deb [arch=amd64] https://dl.bintray.com/tetrate/getenvoy-deb \
        $(lsb_release -cs) \
        nightly"
    sudo apt-get update && sudo apt-get install -y getenvoy-envoy=${envoy_proxy_version}
    envoy --version
}

setup_environment() {

    # Configure Non-Interactive UI to suppress known silent install warnings
    export DEBIAN_FRONTEND=noninteractive
    export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
    export TERM=linux
    export LANGUAGE=en_GB.UTF-8
    export LANG=en_GB.UTF-8
    export LC_ALL=en_GB.UTF-8
    sudo locale-gen en_GB.UTF-8
    sudo update-locale LANG=en_GB.UTF-8

    # Binary versions to check for
    [ -f /usr/local/bootstrap/var.env ] && {
        cat /usr/local/bootstrap/var.env
        source /usr/local/bootstrap/var.env
    }
        
    [ -f var.env ] && {
        cat var.env
        source var.env
    }

    sudo apt-get clean
    sudo apt-get update
    sudo apt-get upgrade -y

    # Update to the latest kernel
    sudo apt-get install -y linux-generic linux-image-generic

    # Hide Ubuntu splash screen during OS Boot, so you can see if the boot hangs
    sudo apt-get remove -y plymouth-theme-ubuntu-text
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
    sudo update-grub

    sudo apt-get install -y -q wget tmux unzip git lynx jq curl net-tools
}

install_go () {
    echo "Start Golang installation"
    which /usr/local/go &>/dev/null || {
        echo "Create a temporary directory"
        sudo mkdir -p /tmp/go_src
        pushd /tmp/go_src
        [ -f go${golang_version}.linux-amd64.tar.gz ] || {
            echo "Download Golang source"
            sudo wget -qnv https://dl.google.com/go/go${golang_version}.linux-amd64.tar.gz
        }
        
        echo "Extract Golang source"
        sudo tar -C /usr/local -xzf go${golang_version}.linux-amd64.tar.gz
        popd
        echo "Remove temporary directory"
        sudo rm -rf /tmp/go_src
        echo "Edit profile to include path for Go"
        echo "export PATH=$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile
        echo "Ensure others can execute the binaries"
        sudo chmod -R +x /usr/local/go/bin/

        source /etc/profile

        go version

    }
}

setup_environment
install_hashicorp_binaries
install_chef_inspec
install_envoy
install_go

# Reboot with the new kernel
shutdown -r now

exit 0

