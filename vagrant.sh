
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
EOF


vagrant up

export KUBECONFIG=$INV/artifacts/admin.conf
