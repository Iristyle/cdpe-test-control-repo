class profile::firewall {

   case $os['family'] {
      'RedHat':   {
        notify { "profile::firewal": }
        include profile::firewall::linux
      }
   }
}
