# This file needs to be ANSI to avoid messing with LANG and other locale things.
# Alternatively, I could repackage the box to set LANG=en_CA.utf8, but I am
# too lazy for that.
$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

# --- Global -------------------------------------------------------------------
# PATH
Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Packages -----------------------------------------------------------------
package { 'curl':
  ensure => installed
}

package { 'sqlite3':
  ensure => installed
}

# Nokogiri pre-reqs.
package { ['libxml2', 'libxslt']:
  ensure => installed
}

# Javascript runtime.
package { 'nodejs':
  ensure => installed
}

# --- Ruby ---------------------------------------------------------------------
# --- Courtesy of @rails for the following section.
exec { 'install_rvm':
  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm/bin/rvm",
  require => [Package['curl'], File['gemrc']]
}

exec { 'install_ruby':
  # We run the rvm executable directly because the shell function assumes an
  # interactive environment, in particular to display messages or ask questions.
  # The rvm executable is more suitable for automated installs.
  #
  # Thanks to @mpapis for this tip.
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install 2.0.0 --latest-binary --autolibs=enabled && rvm --fuzzy alias create default 2.0.0'",
  creates => "${home}/.rvm/bin/ruby",
  require => Exec['install_rvm']
}

# Install bundler via rvm.
exec { "install_bundler":
  command => "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/bin/bundle",
  require => Exec['install_ruby']
}

# --- /vagrant -----------------------------------------------------------------
# Speed up bundler by skipping the docs.
# http://stackoverflow.com/questions/1381725/how-to-make-no-ri-no-rdoc-the-default-for-gem-install
file { 'gemrc':
  path    => "${home}/.gemrc",
  ensure  => file,
  mode    => 0640,
  content => "gem: --no-rdoc --no-ri",
  owner   => "vagrant",
  group   => "vagrant",
}

# --- Development Environment --------------------------------------------------
# Install development and testing gems for segfault.me
# Don't timeout, gems take a long time to compile and install.
exec { 'install_gems':
  command => "${as_vagrant} 'bundle install --without production'",
  cwd     => "/vagrant",
  unless  => "${as_vagrant} 'bundle check'",
  timeout => 0,
  require => Exec['install_bundler']
}

# Ensure we have a mock database configuration.
file { 'database.yml':
  path    => "/vagrant/config/database.yml",
  ensure  => file,
  mode    => 06400,
  content => template("segfault/database.yml.erb"),
  owner   => "vagrant",
  group   => "vagrant",
}

# TODO: Prepare Test DB
# TODO: Seed development && test DBs
# Should we run unit tests upon seeding the box?