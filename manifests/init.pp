# Centralized Logging
# The centralized rsyslog logs will then be an input for Logstash

class rsyslog {

    if $::operatingsystemrelease =~ /^5\./ {
        package { 'rsyslog' :
            ensure => absent,
        }
        package { 'sysklogd' :
            ensure => absent,
            notify => Service[ 'rsyslog' ],
        }
        package { 'rsyslog5' :
            ensure => present,
            notify => Service[ 'rsyslog' ],
        }
    }

    file { '/etc/rsyslog.d' :
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
    }

    file { '/etc/rsyslog.conf' :
        ensure => 'file',
        source => 'puppet:///modules/rsyslog/rsyslog.conf',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify => Service[ 'rsyslog' ],
    }

    service { 'rsyslog' :
        ensure => running,
        enable => true,
    }
}
