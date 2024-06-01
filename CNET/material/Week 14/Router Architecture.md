Routers are fundamental devices in networks, responsible for forwarding packets from one network to another. Their architecture is designed to efficiently handle this task. The key components of a router and their functions are as follows:

#### 1. High-Level View of a Router

- **Data Plane:** This is the part of the router architecture that deals with the actual forwarding of packets. It consists of functions that are performed on each packet, such as lookup, forwarding, and queueing.
- **Control Plane:** This manages the routing processes and the logic that determines the path packets take through the network. It involves routing algorithms and protocols.

#### 2. Input Port Functions

The input port is where packets enter the router. The main functions of the input port include:

- **Line Termination:** Handling the physical layer aspects and terminating the incoming physical link.
- **Link Layer Protocols:** Processing link layer protocols such as Ethernet.
- **Lookup and Forwarding:** Performing the lookup to determine the output port based on the forwarding table.
- **Queueing:** If the switching fabric is busy, packets are queued at the input port.

#### 3. Switching Fabric

The switching fabric is the core of the router, responsible for transferring packets from the input ports to the correct output ports. There are different types of switching fabrics:

- **Switching via Memory:** An older method where the CPU is involved in forwarding decisions. Packets are copied into memory, processed by the CPU, and then copied to the output port. This method is relatively slow.
- **Switching via Bus:** A shared bus connects all input and output ports. Only one packet can cross the bus at a time, which can become a bottleneck in high-speed routers.
- **Switching via Interconnection Network:** Uses a more sophisticated network of crossbars or other switching techniques to allow multiple packets to be forwarded simultaneously. This method is suitable for high-performance routers.

#### 4. Output Port Functions

The output port is where packets leave the router. Key functions include:

- **Queueing:** Packets might need to be queued if the output link is busy.
- **Link Layer Protocols:** Processing for link layer protocols on the outgoing link.
- **Line Termination:** Handling the physical layer aspects and terminating the outgoing physical link.

#### 5. Buffer Management and Packet Scheduling

- **Buffer Management:** Determines which packets to store or drop when buffers (queues) are full. This is crucial for managing congestion.
- **Packet Scheduling:** Determines the order in which packets are transmitted. Common scheduling methods include:
    - **First Come First Served (FCFS):** Packets are transmitted in the order they arrive.
    - **Priority Scheduling:** Higher priority packets are transmitted first.
    - **Round Robin (RR):** Cycles through queues, sending packets from each queue in turn.
    - **Weighted Fair Queuing (WFQ):** A more complex method that ensures fair bandwidth distribution among flows.

#### 6. Input and Output Port Queuing

- **Input Queuing:** When packets arrive faster than they can be forwarded, they are queued at the input ports. This can lead to Head-of-Line (HOL) blocking, where a packet at the front of the queue prevents others from being forwarded.
- **Output Queuing:** Packets are queued at the output port if the outgoing link is busy. This is more efficient than input queuing but requires more buffer memory.

By understanding these components and their functions, you can grasp how routers manage to forward packets efficiently across a network.