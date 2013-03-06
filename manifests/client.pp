# rsyslog client sending to remote rsyslog server with TCP

class rsyslog::client (
    $logserver = 'el6a.labolinux.fr' ) inherits rsyslog {

    file { '/etc/rsyslog.d/send.conf' :
        ensure  => present,
        content => template('rsyslog/send.conf'),
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        notify  => Service[ 'rsyslog' ],
    }
}
