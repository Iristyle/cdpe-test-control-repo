## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'main':
  server => $::servername,
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }


# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }

  # Deliberately do NOT run this code on agent-8. Its for module IA tests!
  if $trusted['certname'] != "cdpe-ia-agent-8.delivery.puppetlabs.net" {
    notify { "Hello world!": message => "I am in the ${environment} environment"}
    notify { "server_facts = ${server_facts}": }
    include cd4pe_tests
  }
}

node 'cdpe-ia-agent-5.delivery.puppetlabs.net' {
  warning("this is a warning from site.pp")
  deprecation("$fake::key", "This fake key has been deprecated for the logs")
  file { '/tmp/impact_analysis_staging_test':
    ensure => file,
    content => 'this is from site.pp'
  }
}
