# wg-easy-dns
Docker-compose with [WireGuard Easy](https://github.com/wg-easy/wg-easy), [CoreDNS](https://github.com/coredns/coredns), and simple python script, that pushes clients info from WG-easy to CoreDNS.

Usage:
```
git clone https://github.com/rokiden/wg-easy-dns.git
cd wg-easy-dns
nano .env
docker-compose up -d
```
WebGUI access:
- for vpn client: `vpn.<WGHOSTS_ZONE>:<WEB_PORT_INTERNAL>`
- `ssh docker_host -L 8080:127.0.0.1:<WEB_PORT_LOCALEXPOSED>` then `localhost:8080`

Configuration `.env`:
| Variable              | Default | Description                                                              |
|-----------------------|---------|--------------------------------------------------------------------------|
| WEB_PORT_INTERNAL     | 80      | WebGUI access from virtual network                                       |
| WEB_PORT_LOCALEXPOSED | 8080    | WebGUI port binding on docker host local interface                       |
| WEB_PASS              | 1234    | WebGUI password                                                          |
| WG_HOST               | 1.2.3.4 | Wireguard server external address/domain, used for clients configuartion |
| WG_PORT               | 1234    | Wireguard server listen port                                             |
| WG_NET_PREFIX         | 10.8.0  | Virtual network address:  WG_NET_PREFIX.0/24                             |
| WGHOSTS_ZONE          | wg.net  | Internal vpn DNS zone, clients names: 'name'.WGHOSTS_ZONE                |
| WGHOSTS_SERVER        | vpn     | Internal vpn DNS server name: WGHOSTS_SERVER.WGHOSTS_ZONE                |

Patch `patch_tooltip.sh`:
Original wg-easy web page uses `title` html attribute for some information, for example `Total Download`.
Modern mobile web browsers doesn't implement feature to show it. This patch adds css to show tooltip on click for mobile devices.
