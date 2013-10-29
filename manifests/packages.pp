class postfix::packages {
  include postfix::params

  package { 'postfix':
    ensure => installed,
  }

  package { 'mailx':
    ensure => installed,
    name   => $postfix::params::mailx_package,
  }

  $use_pcre         = $postfix::use_pcre
  if ( $use_pcre ) {
    case $::operatingsystem {
      /Debian|Ubuntu/: { $postfix_pcre_package = 'postfix-pcre' }
      }
  }

  if ( $postfix_pcre_package ) {
    package { 'postfix-pcre':
      ensure  => installed,
      name    => $postfix_pcre_package,
      require => Package['postfix'],
    }
  }

}
