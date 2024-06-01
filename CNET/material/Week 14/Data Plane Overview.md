The data plane is responsible for the forwarding of packets within a router. It involves local operations performed on each packet, such as encapsulation, addressing, and forwarding. Let's break down the relevant concepts:

#### Datagram

- **Definition:** A datagram is a basic transfer unit associated with a packet-switched network. It contains sufficient information to be routed from the source to the destination without relying on earlier exchanges between the source and destination computers.
- **Structure:** An IP datagram consists of an IP header and a payload. The header includes information necessary for routing and delivery, such as source and destination IP addresses, and control information.

#### Maximum Transmission Unit (MTU)

- **Definition:** The MTU is the largest size of a packet that can be transmitted over a network medium. It includes the packet's header and data.
- **Importance:** MTU affects the efficiency of data transmission. If a datagram exceeds the MTU of the network, it must be fragmented into smaller packets.
- **Common Values:** For Ethernet, the typical MTU is 1500 bytes.

#### IP Fragmentation

**Purpose:** IP fragmentation occurs when a datagram is larger than the MTU of the network it needs to traverse. The datagram is broken into smaller fragments, each fitting within the MTU limit.

**Process:**

1. **Fragmentation Points:** The original datagram is divided at the router or host that performs the fragmentation.
2. **Fragment Headers:** Each fragment retains the original IP header with additional fields to indicate:
    - **Fragment Offset:** Position of the fragment’s data relative to the start of the original datagram.
    - **More Fragments (MF) Flag:** Indicates if more fragments follow.
    - **Identification:** A unique ID for all fragments of the original datagram.

**Example:**

- If an IP datagram is 4000 bytes and the MTU is 1500 bytes:
    - The first fragment would include 1480 bytes of data (20 bytes for the IP header).
    - The second fragment would also include 1480 bytes of data.
    - The third fragment would include the remaining data.

#### IP Defragmentation

**Purpose:** Defragmentation is the process of reassembling the original datagram from its fragments at the destination host.

**Process:**

1. **Collection:** The destination host collects all fragments with the same Identification field.
2. **Reordering:** Fragments are ordered based on their Fragment Offset.
3. **Reassembly:** The original datagram is reconstructed by combining the fragments.

**Handling Fragmentation:**

- **Reassembly Buffer:** The destination host uses a reassembly buffer to hold incoming fragments until all have arrived.
- **Timeout:** If all fragments are not received within a certain time, the partial datagram is discarded to avoid resource exhaustion.

### Detailed Slide Content

#### Datagrams

- **Slide Explanation:** The slides describe the structure of IP datagrams, highlighting fields such as the header, payload, source and destination IP addresses, and control information.

#### IP Fragmentation and MTU

- **Slide Explanation:** The slides explain the need for fragmentation when a datagram exceeds the MTU. They detail how routers handle fragmentation by breaking down the datagram and updating the IP headers of the fragments.

#### IP Fragmentation Process

- **Fields Involved:**
    
    - **Identification:** Unique for each datagram.
    - **Fragment Offset:** Indicates the position of the fragment’s data.
    - **More Fragments (MF) Flag:** Set on all fragments except the last one.
- **Illustration:** The slides likely include diagrams showing how a large datagram is split into smaller fragments, each with a portion of the original data and an updated header.
    

#### Defragmentation

- **Slide Explanation:** The process at the destination host includes collecting fragments, reordering them based on the Fragment Offset, and reassembling the original datagram.
- **Illustration:** Diagrams typically show the reassembly process, emphasizing the role of the reassembly buffer and the importance of the Identification field.

By understanding these concepts, you can grasp how the data plane manages the efficient forwarding and delivery of packets, even when they exceed the size constraints of the network links they traverse.

![[Pasted image 20240526091159.png]]

![[Pasted image 20240526091236.png]]

Unfortunately, fragmentation also has its costs
- Complexity at routers/end systems
- can be used to create lethal DoS attacks

IPv6, does away with fragmentation altogether on router
- End-to-end fragmentation
- Minimum MTU 1280 Bytes
- Hosts uses Path MTU Discovery (PMTUD) to find out maximum packet size or in IPV6 routers expect fitting IPv6 datagrams
- If a router finds out, that packet size is too large for the route to the next hope, it sends the ICMPv6 message (Packet too large) to the sender