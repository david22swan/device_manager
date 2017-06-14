# Manage devices.

define puppet_device (
  Enum['present', 'absent'] $ensure = 'present',
  String $type,
  String $url,
  Boolean $run = false,
) {

  puppet_device::conf::device { $title:
    ensure => $ensure,
    type   => $type,
    url    => $url,
  }

  puppet_device::fact::device { $title:
    ensure => $ensure,
  }

  if ($run and ($ensure == 'present')) {
    exec {"run puppet_device target ${title}":
      command => '/usr/local/bin/puppet device --target $title --user=root --waitforcert 0',
      require => Puppet_device::Conf::Device[$title],
    }
  }
}
