class profile::base {
  #the base profile should include component modules that will be on all nodes
  notify {"profile::base": }

  file { "/tmp/sensitive":
    ensure => file,
    content => Sensitive("totaly not sensitive")
  }

  file { "/home/root":
    ensure => directory
  }

  if $facts['id'] =~ /^user/ {
    class { 'clamps': 
      num_dynamic_files => 1,
      num_static_files  => 1,
    }
  } else {
    class { 'clamps::agent': 
    }
  }

  file { '/tmp/diff-file-params':
    path => "/tmp/${facts['id']}",
    content => 'diff on each user staging',
  }
}
