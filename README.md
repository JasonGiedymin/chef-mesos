chef-mesos Cookbook
===================

Mesos chef cookbook.

Warning: This repo is not yet stable.


Requirements
------------

- `apt`
- `yum`
- `build-essential`
- `java`
- `ark`



Attributes
----------

The following attributes are important:

    # == misc attribs ==
    default['mesos']['install']['force']         = false # force the install

    # == packaging ==
    default['mesos']['install']['mode']          = "local" # {master|slave|local}
    default['mesos']['install']['via']           = "pkg" # {src|pkg_local|pkg} TODO: handle pkg_local
    default['mesos']['install']['pkg_ver']       = '0.14.2'
    default['mesos']['install']['pkg_arch']      = 'amd64'
    default['mesos']['install']['pkg_url']       # the url of the package file
    default['mesos']['install']['pkg_local']     = false # install local file system package {true|false}

    # == compile ==
    default['mesos']['source']['repo']           = 'https://git-wip-us.apache.org/repos/asf/mesos.git'
    default['mesos']['source']['branch']         = 'master' # git branch to compile from


Usage
-----
#### chef-mesos::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `chef-mesos` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-mesos]"
  ]
}
```


Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 

- Jason Giedymin
