# OXID Academy: "personal.yml" templates for Vagrant-based training projects

## Purpose
These files can be copied on top of a freshly checked out project using OXID's Base VM.

## Steps

### Create a new project

Check out OXID's Base VM: (https://github.com/OXID-eSales/oxvm_base). The files should be located in the location where you plan to set up your project.

### Select a configuration

This package comes with 3 prepared versions of the `personal.yml` file. Pick the one which suits you most (e.g. `personal.yml.community-edition` for the basic training)
and rename it to `personal.yml`. Open it with a text editor and modify it as desired. Be sure to stick with the YAML syntax.

### Apply this package

Copy one of the template files `personal.yml.*` file of this package into the root directory of your project and rename it to `personal.yml`.

### Get Vagrant ready

Complete your Vagrant setup, if not done yet:
`vagrant plugin install vagrant-hostmanager vagrant-triggers vagrant-share vagrant-vbguest vagrant-triggers vagrant-bindfs`

### Launch your project VM

Once your local environment is ready, run
`vagrant up`
and be patient. After a while you can access the VM's website by calling http://oxacvm6.local (or as configured) in your web browser. You are now ready to install a project.
