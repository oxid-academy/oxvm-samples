# OXID Academy: "personal.yml" templates for Vagrant-based training projects

## Purpose
These files can be copied on top of a freshly checked out project using OXID's Base VM.

## Steps

### Create a new project

Check out OXID's Base VM: (https://github.com/OXID-eSales/oxvm_base). The files should be located in the location where you plan to set up your project.

### Apply this package

Copy the files of this package into the root directory of your project. When asked whether to overwrite files, confirm.

### Use a configuration

This package comes with 3 prepared versions of the `personal.yml` file. Pick the one which suits you most (e.g. `personal.yml.community-edition` for the basic training)
and rename it to `personal.yml`. Open it with a text editor and modify it as desired. Be sure to stick with the YAML syntax.

### Copy the OXID eShop files

Copy the OXID eShop files of the desired version to the `htdocs` directory. When using OXID eShop Professional Edition or Enterprise Edition, be sure to use the
files for PHP 5.6.

Find OXID eShop CE here: https://github.com/OXID-eSales/oxideshop_ce

### Get Vagrant ready

Complete your Vagrant setup, if not done yet:
`vagrant plugin install vagrant-hostmanager vagrant-triggers vagrant-share vagrant-vbguest vagrant-triggers vagrant-bindfs`

### Launch your project VM

Once your local environment is ready, run
`vagrant up`
and be patient. After a while you can access the shop by calling http://oxacvm.local (or as configured) in your web browser.