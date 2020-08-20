# use virtualenv to install all python requirements
VENVDIR=venv
virtualenv --python=/usr/bin/python3 $VENVDIR
source $VENVDIR/bin/activate
pip install -r requirements.txt

# prepare an inventory to test with
export INV=inventory/my_lab
rm -rf ${INV}.bak &> /dev/null
mv ${INV} ${INV}.bak &> /dev/null
cp -a ../kube_vars ${INV}
rm -f ${INV}/hosts.ini

# customize the vagrant environment
mkdir vagrant
cat << EOF > vagrant/config.rb
\$instance_name_prefix = "kub"
\$vm_cpus = 1
\$num_instances = 3
\$subnet = "10.0.20"
\$network_plugin = "calico"
\$inventory = "$INV"
\$shared_folders = { 'temp/docker_rpms' => "/var/cache/yum/x86_64/7/docker-ce/packages" }
EOF

# make the rpm cache
mkdir -p temp/docker_rpms

vagrant up

# make a copy of the downloaded docker rpm, to speed up the next provisioning run
# scp kub-1:/var/cache/yum/x86_64/7/docker-ce/packages/* temp/docker_rpms/

# copy kubectl access configuration in place
# mkdir $HOME/.kube/ &> /dev/null
export KUBECONFIG=$INV/artifacts/admin.conf
# make the kubectl binary available
# sudo ln -s $INV/artifacts/kubectl /usr/local/bin/kubectl
#or
# export PATH=$PATH:$INV/artifacts

