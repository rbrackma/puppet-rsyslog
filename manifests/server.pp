# rsyslog server listening on TCP

class rsyslog::server inherits rsyslog {

    file { '/etc/rsyslog.d/receive.conf' :
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        content => template('rsyslog/receive.conf'),
        notify  => Service[ 'rsyslog' ],
    }

    include myfirewall

    firewall { '190 rsyslog' :
          chain  => 'INPUT',
          proto  => 'tcp',
          state  => 'NEW',
          dport  => '514',
          action => 'accept',
    }

}
