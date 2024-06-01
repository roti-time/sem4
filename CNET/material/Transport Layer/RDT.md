# RDT 1.0
- Reliable Transfer over a reliable channel
- no bit errors
- no loss of packets

# RDT 2.0
- Channel with bit errors
- may flip bits in packets
- has ACKs and NAKs

What happens if ACK/NAK is corrupted?
# RDT 2.1
- Introduced Seq numbers (0,1)
- If same seq num retransmitted, something got corrupted

# RDT 2.2
- Same as 2.1 but without NAKs
- instead of NAK, receiver sends ACK for last pkt received OK
- receiver must explicitly include seq # of pkt being ACKed

# RDT 3.0
- RDT 2.2 but with timeout