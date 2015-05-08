# OpenData Vagrant Development Environment 

## System setup

If you have never used Vagrant or the OpenData Vagrant development environment, follow these steps first:

1. Ensure you have at least Vagrant version 1.2 installed:
    
       ~$ vagrant --version
	   vagrant version 1.2.2

   If you don't have Vagrant installed or if you have an old version installed, head over to [http://vagrantup.com](http://vagrantup.com) to get it.
   
2. Ensure you have Oracle VirtualBox installed. If not, you can get it here: [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

## First Start Up

The first time you use the OpenData development environment:

1. Run `scripts/devhelpers/setup_etc_hosts.sh` - this will add the necessary entries to your `/etc/hosts` file to be able to access the OpenData server.

2. Go into the `vagrant` directory and start the Vagrant box: `cd vagrant` then `vagrant up`. The first time will take a long time, as it will first download the base OpenData virtual machine. Once this is done, it will update required packages if any have changed (this operation may take some minutes).

3. Try out [http://opendata.localdev.akvo.org/](http://opendata.localdev.akvo.org/)

4. A CKAN admin user for testing purposes has been created for you with the following credentials: `akvo` & `password`.


## Upgrading

Periodically there will be a new base OpenData machine available, which will have updated infrastructure and supporting services. When this is the case, simply `vagrant destroy` to delete your old VM, then `vagrant up` as before; a completely new machine will be created.

You may also want to clean up the old base boxes. They can be found in `$HOME/.vagrant.d/boxes` on UNIXy OSs, and you can simply old ones that you do not use. 


## About the VM

The virtual machine is provisioned with the same [Puppet](http://puppetlabs.com/puppet/what-is-puppet) configuration as the produciton machines. This means that developing locally should take place using exactly the same setup as production.


## FAQ

##### Q: How do I connect to postgreSQL server?
**A**: From your main machine, you can use the script in `scripts/devhelpers/psql.sh` which will connect you as the `postgres` user. You can also `ssh` into the machine (using `vagrant ssh`) and connect by using `sudo -H -u postgres psql`.

##### Q: How can I restart the CKAN application?
**A**: By default, the CKAN application is served by the Apache web server and its modwsgi module. You can use the script `scripts/devhelpers/restart_webserver.sh` to restart the application.

##### Q: I get a 502! Why?
**A**: A 502 Bad Gateway error probably means that no CKAN application is running. You can use the devhelper script `tail_logs.sh error` or `tail_logs.sh custom` to check application's error and custom logs respectively. 



## Helpful notes

* When you are done developing, run `vagrant halt` to shut down the virtual machine, or it'll just sit there consuming system resources.
 
* Run `vagrant ssh` to ssh into the virtual machine. You will then be logged in as the `vagrant` user, who can use sudo without a password.

* The Akvo OpenData custom theme extension root directory is in `/usr/lib/ckan/default/src/akvo-opendata`.

* The `akvo-opendata` repository from your local machine is synced to the virtual machine at the above-mentioned directory. The custom theme extension is installed by running `python setup.py develop`, which adds a .egg-link file to your python site-packages directory (which is on your python path). This allows the extension to be imported and used. Any changes made to the extension source code on your local machine are shown up immediately into the vagrant without needing to be reinstalled.


## Useful scripts
There are a variety of useful scripts in `scripts/devhelpers`:

* `setup_etc_hosts.sh` will add the necessary IP/address combinations to your `/etc/hosts` file.

* `cleanup_etc_hosts.sh` will remove those entries at `/etc/hosts`.

* `psql.sh` will connect to the postgreSQL server on the virtual machine as `postgres` user.

* `create_admin.sh` will create a new admin user, which can access and edit any organizations, view and change user details, as well asadd, update and delete datasets. As stated before, a test admin user has already been created for you.

* `restart_webserver.sh` will restart the Apache service and, therefore, the CKAN application itself.

* `tail_logs.sh` will tail CKAN application error or custom log files.
