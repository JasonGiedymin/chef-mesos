chef-mesos Cookbook
===================

Mesos chef cookbook.

Warning: This repo is not yet stable.

Note: There is a lot of raw ruby that will be moved to both blocks and 
      lwrp directives. Maybe you can help out!? :-)


Requirements
------------
TODO

e.g.
#### packages
- `toaster` - chef-mesos needs toaster to brown your bagel.

Attributes
----------

Install from package local. Note, that it will fall back to remote if local
doesn't exist.

    default['mesos']['install']['pkg_local']

e.g.
#### chef-mesos::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chef-mesos']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

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
Authors: Jason Giedymin
