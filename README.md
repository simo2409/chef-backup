backup Cookbook
====================
This cookbook setups [backup](https://github.com/backup/backup) to backup
MySQL/MariaDB database into an S3 bucket.

At the moment this recipe is VERY incomplete and cover only 1 very specific use case:
it creates a backup of a single db (from MySQL/MariaDB), compress it and stores it into AWS S3.

Requirements
------------
This recipe requires [cron cookbook](https://github.com/chef-cookbooks/cron)
Just drop

``` ruby
cookbook 'cron'
```

in your Cheffile and run ``librarian-chef install``

Attributes
----------
```json
{
  "enabled": true,
    "user": "..",
    "destination": {
      "to": "s3",
      "access_key_id": "..",
      "secret_access_key": "..",
      "bucket_name": "..",
      "region": ".."
    },
    "hooks": {
      "slack": {
        "webhook_url": ".."
      }
    }
}
```

#### backup::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['backup']['enabled']</tt></td>
    <td>Boolean</td>
    <td>whether to setup backup or not</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['user']</tt></td>
    <td>String</td>
    <td>user which performs backup (configuration file will be placed in its home directory)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['destination']['to']</tt></td>
    <td>String</td>
    <td>destination kind (for the moment it must be "s3")</td>
    <td><tt>"s3"</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['destination']['access_key_id']</tt></td>
    <td>String</td>
    <td>AWS access key id</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['destination']['secret_access_key']</tt></td>
    <td>String</td>
    <td>AWS secret access key</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['destination']['bucket_name']</tt></td>
    <td>String</td>
    <td>AWS bucket name</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['destination']['region']</tt></td>
    <td>String</td>
    <td>AWS region</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backup']['hooks']['slack']['webhook_url']</tt></td>
    <td>String</td>
    <td>URL of the slack's webhook where to put backup's notifications</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
#### backup::default
Just include `backup` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum_repos]"
  ]
}
```

and add needed attributes (you can use the structure above)

Contributing
------------
This recipe is highly not complete, until it will be more completed it's not worth to contribute on it.

License and Authors
-------------------
License: MIT

Authors:

Simone Dall'Angelo
















yum_repos Cookbook
==================
This cookbook installs EPEL and Remi repos into CentOs 7.

Requirements
------------
CentOS 7

Attributes
----------
None

Usage
-----
#### yum_repos::default
Just include `yum_repos` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum_repos]"
  ]
}
```

Contributing
------------
Need help for testing following best practises, if you can help you are welcome!

License and Authors
-------------------
License: MIT

Authors:

Simone Dall'Angelo
