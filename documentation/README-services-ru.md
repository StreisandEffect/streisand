<a name="services-provided"></a>
Предоставляемые сервисы
-----------------
* L2TP/IPsec с использованием [Libreswan](https://libreswan.org/) и [xl2tpd](https://www.xelerance.com/software/xl2tpd/)
  * Создаются случайные ключ и пароль
  * Пользователи Windows, macOS, Android, и iOS  могут подключаться с использованием встроенной поддержки VPN без установки дополнительного ПО.
* [Monit](https://mmonit.com/monit/)
  * Отслеживает здоровье процессов и автоматически перезапускает их , если они падают или зависают.
* [OpenSSH](http://www.openssh.com/)
  * Создается непривилегированный пользователь и пара ключей для [sshuttle](https://github.com/sshuttle/sshuttle) и SOCKS.
  * Поддерживаются также SSH-туннели Windows и Android, создается копия пары ключей в .ppk формате для PuTTY
  * Установлен [Tinyproxy](https://banu.com/tinyproxy/) и подключен к localhost. Программы, которые не поддерживают SOCKS и требуют наличия HTTP proxy, такие как Twitter для Android, могу подключиться к нему через SSH-туннель.
* [OpenConnect](http://www.infradead.org/ocserv/index.html) / [Cisco AnyConnect](http://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * OpenConnect (ocserv) - высокопроизводительный и легковесный VPN-сервер полностью совместимый с официальными клиентами Cisco AnyConnect.
  * Его [протокол](http://www.infradead.org/ocserv/technical.html) построен на классических стандартах, таких как HTTP, TLS и  DTLS и является одним из самых популярных и широко используемых мультинациональными корпорациями VPN технологий.
    * Это означает, что кроме своей простоты и скорости, OpenConnect также устойчив к цензуре и практически никогда не блокируется.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * Для каждого клиента создаются унифицированные .ovpn профили для простой настройки клиента с использованием только одного файла.
  * Поддерживаются соединения TCP и UDP.
  * Определение адресов для клиента исползует [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) для предотвращения утечек DNS-запросов.
   *  Включена TLS Authentication для защиты от зондирующих атак. Трафик не имеющий корректного HMAC будет попросту проигнорирован.
* [Shadowsocks](http://shadowsocks.org/en/index.html)
  * Установлен высокопроизводительный [вариант libev](https://github.com/shadowsocks/shadowsocks-libev). Эта версия обрабатывает тысячи одновременных соединений.
  * Создается QR код который можно использовать для автоматической настройки Android и iOS клиентов. Вы можете написать '8.8.8.8' на бетонной стене, или вы можете наклеить инструкции для Shadowsocks и QR коды на ту же стену.
  * Включена поддержка [AEAD](https://shadowsocks.org/en/spec/AEAD-Ciphers.html) с ChaCha20 и Poly1305 для усиленной безопасности и уклонения от GFW.
* [sslh](http://www.rutschle.net/tech/sslh.shtml)
  * Sslh - демультиплексор протоколов, позволяющий Nginx, OpenSSH и  OpenVPN совместно использовать порт 443. Это предоставляет альтернативный метод подключения и означает, что вы можете перенаправлять трафик через OpenSSH и OpenVPN даже если вы находитесь в сети с очень строгими правилами, которая блокирует все соединения не с HTTP.
* [Stunnel](https://www.stunnel.org/index.html)
  * Слушает и упаковывает соединения OpenVPN. Это заставляет их выглядеть как стандартный SSL трафик и позволяет OpenVPN клиентам устанавливать туннели даже в случае использования Deep Packet Inspection.
  * Создаются как профили для прямых соединений, так и унифицированные профили для соединений OpenVPN через stunnel. И подробные инструкции тоже.
  * Сертификат stunnel и ключ экспортируются в формате PKCS #12 для совместимости с другими приложениями для туннелирования SSL. В частности , это позволяет [OpenVPN for Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn) туннелировать свой трафик через [SSLDroid](https://play.google.com/store/apps/details?id=hu.blint.ssldroid). OpenVPN в Китае на мобильном устройстве? Да!
* [Tor](https://www.torproject.org/)
  * Настроен  [bridge relay](https://www.torproject.org/docs/bridges) со случайно сгенерированным именем.
  * Установлен [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) и настроен с поддержкой подключаемого транспорта obfs4.
  * Сгенерирован код BridgeQR для автоматического конфигурирования [Orbot](https://play.google.com/store/apps/details?id=org.torproject.android) для Android.
* [UFW](https://wiki.ubuntu.com/UncomplicatedFirewall)
  * Для каждого сервиса настроены правила файрвола, так что любой трафик отправленный на запрещенный порт будет заблокирован.
* [unattended-upgrades](https://help.ubuntu.com/community/AutomaticSecurityUpdates)
  * Ваш Стрейзанд сервер настроен для автоматической установки обновлений, связанных с безопасностью.
* [WireGuard](https://www.wireguard.io/)
  * Пользователи Linux могут насладиться простым и прекрасным VPN, который также является сказочно быстрым и использует современные криптографические принципы, отсутствующие в других высокоскоростных VPN решениях
