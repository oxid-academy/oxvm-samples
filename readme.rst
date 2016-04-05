# OXID Academy: "personal.yml" templates for OXVM

## Purpose
These files are provided as samples for usage with the [OXVM](https://github.com/OXID-eSales/oxvm_eshop). Please refer to the training preparation manual in order to learn how to use these files.

These files are ready-to-use samples and can be used within your OXVM without modification -- but we recommend to modify them, e.g.
* change the name of the VM
* change the hostname
* manage resources
* select/unselect features
* add your GitHub Auth Token (recommended, for Composer)

## Provided files
* "Base", for a quick setup. Perfect for basic trainings like the developer certification.
* "Performance Features", prepared to install the Varnish Reverse Proxy.

## Hints
In order to prevent OXVM from downloading and installing OXID eShop CE, simply provide existing shop files in the shop's home directory. In the example: `/var/www/htdocs/source`.
