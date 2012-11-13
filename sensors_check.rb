#!/usr/bin/ruby
# encoding: utf-8

# sensors_check.rb
# Check CPU temperature by sensors command
# and send alert mail if the temperature is critical.
# version: 1.0
# update:  2012/11/12
# since:   2012/11/10
# author:  Moza USANE

require "mail"
require "syslog"

def send_alert_mail(temperature)
  mail = Mail.new do
    from    "put@your.email.address"
    to      "put@your.email.address"
    subject "*** CPU TEMPERATURE ALERT!! ***"
    body    "CPU temperature of my machine is critical.\ntemperature: #{temperature}"
  end

  mail.delivery_method(:smtp, {
    address:    "localhost",
    port:       "25",
    domain:     "localhost",
    #user_name: "icecube"
    #password:  "password (You must not hard code your password there.)"
  })

  mail.deliver!
end

def write_syslog(temperature)
  Syslog.open($0)
  Syslog.log(Syslog::LOG_USER, "CPU temperature is critical(temperature: #{temperature})")
  Syslog.close
end

result = `sensors`

result.each_line do |line|
  current_temp = Float::MIN
  critical_temp = Float::MIN

  if line =~ /Physical id \d+:\s+\+(\d+\.\d+)°C/
    current_temp = Float($1)
  elsif line =~ /Core \d+:\s+\+(\d+\.\d+)°C/
    current_temp = Float($1)
  end

  if line =~ /high = \+(\d+\.\d+)°C/
    critical_temp = Float($1)
  end

  if current_temp > critical_temp
    send_alert_mail(current_temp)
    write_syslog(current_temp)
    exit
  end
end

