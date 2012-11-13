sensors_check.rb README
=======================

## Introduction

sensors_check.rb monitors CPU temperature by using cron and sensors command. It alerts you by email and syslog if CPU temperature gets critical.

## Operation Environment

We checked good operation in Linux(openSUSE 12.2) and Ruby 1.9.3. Also notification of syslog was checked in KDE.

## Architectonics

- sensors_check.rb: Main script.
- sensors_check.sh: A Shell script called by cron to launch sensors_check.rb.

## Implementation

### Modifying scripts

Open the scripts with an editor you like. Then modify the scripts.

#### Modifying of sensors_check.rb

First, configure email address to receive alert. Input your email address 17-18 lines in send_alert_mail method. Second, modify SMTP server information in mail_delivery_method method's argument.

We recommend you must not hard code userID and password if you use SMTP server with authentication. Instead of the wrong way, prepare a SMTP server in your machine. The SMTP server must arrow connecting from localhost only.

#### Modifying of sensors_check.sh

Modify path of cd command's argument in line 6. The path is full path of directory that put sensors_check.rb and sensors_check.sh.

### Put the launch command to cron

We will show an example of cron setting.

First, open config file of cron to add cron job by using following command. When use the command, cron's config file opened by an editor($EDITOR).

`$ crontab -e`

Second, add following the string. It grants the scripts put on /home/icecube/bin.

`*/5 * * * * /home/icecube/bin/sensors_check.sh > /dev/null 2>&1`

With that, implementation has been finishd. Have fun!

## About Author

Moza USANE
http://blog.quellencode.org/
mozamimy@quellencode.org