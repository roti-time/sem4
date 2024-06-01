## IP SERVING

IP = 32
SUBNET = network bits on (netmask)
off bits = host bits

11111111.11111111.11111111.11111100
30 on bits (netmask)
2 off bits

41.0.0.0 100000
41.2.0.0 (next network)

41.10.40.0 (router IPs start here)
1 connection (router to router)
you need two IPS

41.10.40.0 (network IP)
41.10.40.1 (usable)
41.10.40.2 (usable)
41.10.40.3 (broadcast)
41.10.40.4 (next network IP)
/30 (netmask)

41.10.40.(smthn)

## NAT command 

1. `ip nat inside source static (private IP) (public IP)`
2. `ip nat inside source static 192.168.1.0  10.0.0.1`

## OSPF

Router>
`en`
`config t`
`Router (config)`
`router ospf (number)`
`Router (router-config)`
`network 41.10.40.0 255.255.255.252 area 1`

## RIP

put all connection network IPs in RIP table in config


## EIGRP
(similar to OSPF)
router>

`en`
`config t`
`router (config)#`
`router eigrp (number)`
`router (router-config)#`
`network 41.0.0.0 255.254.0.0` 
`exit`
`Router #`
`copy running-config startup-config`
`desti (press enter)`
`[OK]`



## REDISTRIBUTION

### EIGRP-OSPF

`router ospf (number)`
`redistribute eigrp (number) subnets`
`exit`
`router eigrp (number)`
`redistribute ospf (number) metric 2 0 255 100 1500`

(I used the exact command above and it worked for me)

^Z
`copy running-config startup-config`
`[PRESS ENTER]`



### RIP-OSPF

`ver2`
`router ospf (number)`
`redistribute rip subnets`
`exit`
`router rip`
`redistribute ospf (number) metric 1`




## DHCP NOT WORKING ON OTHER NETWORKS
1. Go to the edge router (the router connecting the host network to the router networks

2. on the router (with he interface the host network is connected on, selected
	
	`ip helper <server ip address> (enter literal server ip)`
	`exit`
	`copy run start`

3. Fast forward
## TO BLOCK ONE HOST FROM USING THE SERVER SERVICES 

`enable`
`config t`
`access-list (random number for accesslist) deny ip (host ip) (wildcard mask)(server ip)`
`interface (the interface connected with the host network)`
`ip access-group (accesslist number) out`
`exit`
`copy running-config startup-config`
`[ENTER]`