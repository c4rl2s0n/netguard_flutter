// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netguard/common/logic/tools/parsing_tools.dart';

import 'package:netguard/main.dart';

String hostsSample = """
### The Ultimate hosts file for Linux / Unix / Windows / Android based operating Systems
### Copyright (c) 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 Ultimate Hosts Blacklist - @Ultimate-Hosts-Blacklist Contributors
### Copyright (c) 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 Mitchell Krog - @mitchellkrogza
### Copyright (c) 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 Nissar Chababy - @funilrys
### Repo Url: https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist

##############################################################################################################################
#                                                                                                                            #
#  ##     ## ##       ######## #### ##     ##    ###    ######## ########    ##     ##  #######   ######  ########  ######   #
#  ##     ## ##          ##     ##  ###   ###   ## ##      ##    ##          ##     ## ##     ## ##    ##    ##    ##    ##  #
#  ##     ## ##          ##     ##  #### ####  ##   ##     ##    ##          ##     ## ##     ## ##          ##    ##        #
#  ##     ## ##          ##     ##  ## ### ## ##     ##    ##    ######      ######### ##     ##  ######     ##     ######   #
#  ##     ## ##          ##     ##  ##     ## #########    ##    ##          ##     ## ##     ##       ##    ##          ##  #
#  ##     ## ##          ##     ##  ##     ## ##     ##    ##    ##          ##     ## ##     ## ##    ##    ##    ##    ##  #
#   #######  ########    ##    #### ##     ## ##     ##    ##    ########    ##     ##  #######   ######     ##     ######   #
#                                                                                                                            #
#  ########  ##          ###     ######  ##    ## ##       ####  ######  ########                                            #
#  ##     ## ##         ## ##   ##    ## ##   ##  ##        ##  ##    ##    ##                                               #
#  ##     ## ##        ##   ##  ##       ##  ##   ##        ##  ##          ##                                               #
#  ########  ##       ##     ## ##       #####    ##        ##   ######     ##                                               #
#  ##     ## ##       ######### ##       ##  ##   ##        ##        ##    ##                                               #
#  ##     ## ##       ##     ## ##    ## ##   ##  ##        ##  ##    ##    ##                                               #
#  ########  ######## ##     ##  ######  ##    ## ######## ####  ######     ##                                               #
#                                                                                                                            #
##############################################################################################################################

### MIT LICENSE

### You are free to copy and distribute this file for non-commercial uses,
### as long the original URL and attribution is included.

### Please forward any additions, corrections or comments by logging an issue at
### https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/issues


##### Version Information #
#### Version: V2.2925.2025.07.15
#### Total Hosts: 976,702
##### Version Information ##

# Use this file to prevent your computer or server from connecting to selected
# internet hosts. This is an easy and effective way to protect you from
# many types of spyware, adware, malware, click-jacking and porn sites and reduces
# bandwidth use.

# The file should be named "hosts" NOT "hosts.txt"

# For Linux based Operating systems place this file at "/etc/hosts"

# For Windows based systems this is placed either at
# C:\windows\system32\drivers\etc\hosts
# or C:\Windows\System32\drivers\etc\hosts

127.0.0.1 localhost
127.0.0.1 localhost.localdomain
127.0.0.1 local
255.255.255.255 broadcasthost
::1 localhost
fe80::1%lo0 localhost
0.0.0.0 0.0.0.0

# START HOSTS LIST ### DO NOT EDIT THIS LINE AT ALL ###
0.0.0.0 0.0.0.0forum.cryptonight.net
0.0.0.0 0.0.0.0mail.nanopool.org
0.0.0.0 0.0.0.0mailgate.cryptonight.net
0.0.0.0 0.0.0.0ns10.cryptonight.net
0.0.0.0 0.0.0.0ssl.cryptonight.net
0.0.0.0 0.0.0.0ws01.coinlab.biz
0.0.0.0 0.0.0assets.cryptonight.net
0.0.0.0 0.0.0cdn-102.statdynamic.com
0.0.0.0 0.0.0cdn.adx1.com
0.0.0.0 0.0.0dbs.cryptonight.net
0.0.0.0 0.0.0fileserver.cryptonight.net
0.0.0.0 0.0.0hb.adx1.com
0.0.0.0 0.0.0img.sedoparking.com
0.0.0.0 0.0.0mail3.cryptonight.net
0.0.0.0 0.0.0ns6.cryptonight.net
0.0.0.0 0.0.0rtb.adx1.com
0.0.0.0 0.0.0t.cryptonight.net
0.0.0.0 0.0.0wsus.cryptonight.net
0.0.0.0 0.0.0www1.sedoparking.com
0.0.0.0 0.0.0www2.sedoparking.com
0.0.0.0 0.0.0www4.sedoparking.com
0.0.0.0 0.0.0www.de-ner-mi-nis4.info
0.0.0.0 0.0.0www.julrina.000webhostapp.com
0.0.0.0 0.0.0www.ner-de-mi-nis-6.info
0.0.0.0 0.0.0www.sedoparking.com
0.0.0.0 0.0.0xml.adx1.com
0.0.0.0 0.0.1rtb.adx1.com
0.0.0.0 0.0.1rtd-tm.everesttech.net
0.0.0.0 0.0.1www.sedoparking.com
0.0.0.0 0.0.2.api.binance.com
0.0.0.0 0.0.2.dev.api.binance.com
0.0.0.0 0.0.2.eu.api.binance.com
0.0.0.0 0.0.2.us.api.binance.com
0.0.0.0 0.0.250analytics.com
0.0.0.0 0.0.b.c.0.0.4.2.api.binance.com
0.0.0.0 0.0.b.c.0.0.4.2.dev.api.binance.com
0.0.0.0 0.0.b.c.0.0.4.2.eu.api.binance.com
0.0.0.0 0.0.b.c.0.0.4.2.us.api.binance.com
0.0.0.0 0.0.exactag.com
0.0.0.0 0.00000.life
0.0.0.0 0.0.pages03.net
0.0.0.0 0.0.planetdoc.info
0.0.0.0 0.0.www.ato.mx
0.0.0.0 0.0cdn-102.statdynamic.com
0.0.0.0 0.0cdn.adx1.com
0.0.0.0 0.0hb.adx1.com
0.0.0.0 0.0hb.adx1.com0.0rtb.adx1.com
0.0.0.0 0.0img.sedoparking.com
0.0.0.0 0.0l.cryptonight.net
0.0.0.0 0.0mx03.cryptonight.net
0.0.0.0 0.0rtb.adx1.com
0.0.0.0 0.0www1.sedoparking.com
0.0.0.0 0.0www2.sedoparking.com
0.0.0.0 0.0www4.sedoparking.com
0.0.0.0 0.0www.de-ner-mi-nis4.info
0.0.0.0 0.0www.julrina.000webhostapp.com
0.0.0.0 0.0www.ner-de-mi-nis-6.info
0.0.0.0 0.0www.sedoparking.com
0.0.0.0 0.0www.spiky-inclinations.000webhostapp.com
0.0.0.0 0.0www.thewhizmarketing.com
0.0.0.0 0.0www.xerox300.000webhostapp.com
0.0.0.0 00.0x1f4b0.com
0.0.0.0 0.0xml.adx1.com
0.0.0.0 0.0xml.adx1.com0.0.0xml.adx1.com
0.0.0.0 0.1routerlogin.net
0.0.0.0 0.1rtb.adx1.com
0.0.0.0 0.1rtd-tm.everesttech.net
0.0.0.0 0.1www.sedoparking.com
0.0.0.0 0.2.api.binance.com
0.0.0.0 0.2.dev.api.binance.com
0.0.0.0 0.2.eu.api.binance.com
0.0.0.0 0.2.us.api.binance.com
0.0.0.0 0.9.0.0.9.theballoonsquad.co.uk
0.0.0.0 0.20alemaniacosentino1.solution.weborama.fr
0.0.0.0 0.20cdn.adx1.com
0.0.0.0 0.20engage.commander1.com
0.0.0.0 0.20fabianafilippi.commander1.com
0.0.0.0 0.20img.sedoparking.com
0.0.0.0 0.20mattel-app.quantummetric.com
0.0.0.0 0.20pvcgocnz.micpn.com
0.0.0.0 0.20radiowoche.onesignal.com
0.0.0.0 0.141.hostpro.com.ua.domain.name
0.0.0.0 0.201nf6hixc.micpn.com
0.0.0.0 0.232.205.92.host.secureserver.net
0.0.0.0 0.250analytics.com
0.0.0.0 00.250analytics.com
0.0.0.0 0.2082xq.adj.st
0.0.0.0 0.178-81.ual.bitcoin.com
0.0.0.0 0.178-81.ual.eu.bitcoin.com
0.0.0.0 0.178-81.ual.ru.bitcoin.com
0.0.0.0 0.178-81.ual.us.bitcoin.com
0.0.0.0 000.abreubueno91.repl.co
0.0.0.0 0.abseits.ski
0.0.0.0 0.accountkit.com
0.0.0.0 0.adnxs.com
0.0.0.0 000000.ads.tremorhub.com
0.0.0.0 0.adx1.com
0.0.0.0 0.afs.googleadservices.com
0.0.0.0 0.alburyclub.com
0.0.0.0 00.api.binance.com
0.0.0.0 0.api.binance.com
0.0.0.0 000000.api.binance.com
0.0.0.0 0.as.bitcoin.com
0.0.0.0 0.as.eu.bitcoin.com
0.0.0.0 0.as.ru.bitcoin.com
0.0.0.0 0.as.us.bitcoin.com
0.0.0.0 0.awal122182.000webhostapp.com
0.0.0.0 0.bgeneral0.repl.co
0.0.0.0 0.bigclicker.me
0.0.0.0 00.binance.com
0.0.0.0 0-0.binance.com
0.0.0.0 0.binance.com
0.0.0.0 00.bitcoin.com
0.0.0.0 0.bitcoin.com
0.0.0.0 00.bsod.pw
0.0.0.0 00.buh30-00.ru
0.0.0.0 0.callrail.com
0.0.0.0 0.capitalgroupp.000webhostapp.com
0.0.0.0 0.clickid147.filter.clickbank.net
0.0.0.0 0000.com.my
0.0.0.0 00.config.parsely.com
0.0.0.0 0.creative.hpyrdr.com
0.0.0.0 00.creativecdn.com
0.0.0.0 000000000000000000.cybertek-peru.com
0.0.0.0 0.datadog.pool.ntp.org
0.0.0.0 0.de.pool.ntp.org.domain.name
0.0.0.0 000000.deeplink.mobileapptracking.com
0.0.0.0 0.dev.api.binance.com
0.0.0.0 000000.dev.api.binance.com
0.0.0.0 00.dev.api.binance.com
0.0.0.0 0.easyhash.de
0.0.0.0 000000.ecrtb.adtelligent.com
0.0.0.0 0.etarget.sk
0.0.0.0 000000.eu.api.binance.com
0.0.0.0 0.eu.api.binance.com
0.0.0.0 00.eu.api.binance.com
0.0.0.0 0.eu.bitcoin.com
0.0.0.0 00.eu.bitcoin.com
0.0.0.0 0.eu.mine.eu.mine.zpool.ca
0.0.0.0 0.eu.mine.ja.mine.zpool.ca
0.0.0.0 0.eu.mine.mine.zpool.ca
0.0.0.0 0.eu.mine.us.mine.zpool.ca
0.0.0.0 0.eu.mine.zpool.ca
0.0.0.0 000000.eurtb.adtelligent.com
0.0.0.0 0.exactag.com
0.0.0.0 00.exactag.com
0.0.0.0 0.extole.io
0.0.0.0 0.fascinatingsciencemag.com
0.0.0.0 0.feixue316p.cloudns.biz
0.0.0.0 0.feixue317p.cloudns.biz
0.0.0.0 0.feixue318p.cloudns.biz
0.0.0.0 00000000000000000000000.fielty.mx
0.0.0.0 0.findmedia.biz
0.0.0.0 0000000000000000000000000.findyourjacket.com
0.0.0.0 0.fls.doubleclick.net
0.0.0.0 0000.fls.doubleclick.net
0.0.0.0 000000.fls.doubleclick.net
0.0.0.0 0000000.fls.doubleclick.net
0.0.0.0 0.fres-news.com
0.0.0.0 000.gaysexe.free.fr
0.0.0.0 0.glancecdn.net
0.0.0.0 00.glancecdn.net
0.0.0.0 0.gogorithm.com
0.0.0.0 00.gogorithm.com
0.0.0.0 000.gr.com
...
""";

void main() {

  test("Test parsing a hosts file", () {
    List<String> hosts = ParsingTools.parseHosts(hostsSample).hosts;
    expect(hosts.length, greaterThan(0));
  });
}
