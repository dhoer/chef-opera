# Opera Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/opera.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-opera.svg?style=flat-square)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/opera
[travis]: https://travis-ci.org/dhoer/chef-opera
                          
This cookbook installs Chromium-based Opera browser (http://www.opera.com/) at compile time and provides 
`opera_version` library method  to retrieve Opera browser version installed.

## Requirements

Chef 11.16+

### Platforms

- Ubuntu
- Windows

### Cookbooks

- apt

## Usage

Include the default recipe on a node's runlist to ensure that opera is installed.

A library method `opera_version` is provided to retrieve the opera version installed:

```ruby
v = opera_version # => '29.0.1795.60'
```

**Tip:** use `allow_any_instance_of` to stub opera_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:opera_version).and_return('29.0.1795.60')
```

### Attributes

- `node['opera']['track']` - Install latest `stable` or `beta` release of Opera browser. Default is `stable`.

See [attributes/default.rb](https://github.com/dhoer/chef-opera/blob/master/attributes/default.rb) for complete list 
of attributes.

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-opera).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-opera/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-opera/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-opera/blob/master/LICENSE.md) file for details.
