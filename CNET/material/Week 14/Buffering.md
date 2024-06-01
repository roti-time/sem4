**Buffering** refers to the temporary storage of packets in memory (buffers) within a router. Buffers are necessary because the arrival rate of packets can sometimes exceed the forwarding rate, leading to temporary congestion.

**Key Points about Buffering:**

- **Location:** Buffers can be located at both the input and output ports of a router.
- **Purpose:** Buffers store packets when they cannot be immediately forwarded due to congestion or limited bandwidth.

#### Input Port Buffering

- **Function:** Stores packets that have arrived at an input port but cannot be immediately forwarded to the switching fabric or output port.
- **Head-of-Line (HOL) Blocking:** This occurs when the first packet in the queue cannot be forwarded, blocking subsequent packets from being processed even if their paths are clear. HOL blocking can significantly reduce router throughput.

#### Output Port Buffering

- **Function:** Stores packets that have been processed by the switching fabric but cannot be transmitted immediately due to limited bandwidth on the outgoing link.
- **Advantages:** Reduces the likelihood of HOL blocking compared to input port buffering but requires larger buffer sizes.

### Buffer Management

**Buffer Management** involves deciding which packets to store, drop, or prioritize when buffer space is limited. Effective buffer management helps mitigate congestion, minimize packet loss, and ensure fair distribution of resources.

#### Key Techniques for Buffer Management

1. **Tail Drop:**
    
    - The simplest approach, where incoming packets are dropped when the buffer is full.
    - **Drawback:** Can lead to global synchronization in TCP, where multiple flows reduce their transmission rate simultaneously, reducing network throughput.
2. **Random Early Detection (RED):**
    
    - Proactively drops packets before the buffer is full to signal congestion to senders.
    - **Mechanism:** Monitors the average queue size and drops packets with a probability that increases as the average queue size grows.
    - **Benefit:** Helps avoid global synchronization and maintains high throughput.
3. **Weighted Random Early Detection (WRED):**
    
    - An extension of RED that assigns different drop probabilities to different types of traffic, allowing for differentiated handling based on traffic class.

#### Packet Scheduling

Packet scheduling determines the order in which packets are transmitted from the buffer. Various algorithms ensure efficient and fair packet forwarding.

1. **First Come First Served (FCFS):**
    
    - Packets are transmitted in the order they arrive.
    - **Simple** but may not be fair in terms of bandwidth distribution among flows.
2. **Priority Scheduling:**
    
    - Packets are assigned different priority levels, with higher priority packets transmitted first.
    - **Ensures timely delivery** of critical packets but can lead to starvation of low-priority traffic.
3. **Round Robin (RR):**
    
    - Cycles through different queues, sending one packet from each queue in turn.
    - **Fair** distribution but may not handle priority traffic efficiently.
4. **Weighted Fair Queuing (WFQ):**
    
    - A more sophisticated algorithm that allocates bandwidth fairly among different flows based on their weights.
    - **Balances fairness** and efficiency, ensuring no single flow monopolizes the buffer.

### Example in the Context of Router Architecture

1. **Input Port Buffering:**
    
    - Packets arriving at an input port are temporarily stored if the switching fabric is busy.
    - Queuing discipline (e.g., FIFO) manages packet order.
2. **Output Port Buffering:**
    
    - After packets are processed by the switching fabric, they are stored at the output port if the outgoing link is busy.
    - Buffer management techniques (e.g., RED, WRED) help manage congestion and minimize packet loss.
3. **Packet Scheduling:**
    
    - Determines the order in which packets are sent from the output buffer to the outgoing link.
    - Algorithms like FCFS, Priority Scheduling, and WFQ ensure fair and efficient packet transmission.

By understanding buffering and buffer management, you can see how routers handle network congestion, prioritize traffic, and maintain efficient data flow.

![[Screenshot from 2024-05-26 08-45-26.png]]

