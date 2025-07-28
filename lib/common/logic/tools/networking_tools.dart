class NetworkingTools {
  static String toProtocol(int protocol) => switch (protocol) {
    Protocols.IPPROTO_IP => "IP",
    Protocols.IPPROTO_ICMP => "ICMPv4",
    Protocols.IPPROTO_IGMP => "IGMP",
    Protocols.IPPROTO_IPIP => "IPIP",
    Protocols.IPPROTO_TCP => "TCP",
    Protocols.IPPROTO_EGP => "EGP",
    Protocols.IPPROTO_PUP => "PUP",
    Protocols.IPPROTO_UDP => "UDP",
    Protocols.IPPROTO_IDP => "IDP",
    Protocols.IPPROTO_TP => "TP",
    Protocols.IPPROTO_DCCP => "DCCP",
    Protocols.IPPROTO_IPV6 => "IPV6",
    Protocols.IPPROTO_ROUTING => "ROUTING",
    Protocols.IPPROTO_FRAGMENT => "FRAGMENT",
    Protocols.IPPROTO_RSVP => "RSVP",
    Protocols.IPPROTO_GRE => "GRE",
    Protocols.IPPROTO_ESP => "ESP",
    Protocols.IPPROTO_AH => "AH",
    Protocols.IPPROTO_ICMPV6 => "ICMPv6",
    Protocols.IPPROTO_NONE => "NONE",
    Protocols.IPPROTO_DSTOPTS => "DSTOPTS",
    Protocols.IPPROTO_MTP => "MTP",
    Protocols.IPPROTO_BEETPH => "BEETPH",
    Protocols.IPPROTO_ENCAP => "ENCAP",
    Protocols.IPPROTO_PIM => "PIM",
    Protocols.IPPROTO_COMP => "COMP",
    Protocols.IPPROTO_L2TP => "L2TP",
    Protocols.IPPROTO_SCTP => "SCTP",
    Protocols.IPPROTO_MH => "MH",
    Protocols.IPPROTO_UDPLITE => "UDPLITE",
    Protocols.IPPROTO_MPLS => "MPLS",
    Protocols.IPPROTO_ETHERNET => "ETHERNET",
    Protocols.IPPROTO_RAW => "RAW",
    Protocols.IPPROTO_MPTCP => "MPTCP",
    _ => protocol.toString(),
  };
  static String toPortAwareProtocol(int protocol, int port) => switch (port) {
    53 => switch (protocol) {
      Protocols.IPPROTO_UDP => "DNS/UDP",
      Protocols.IPPROTO_TCP => "DNS/TCP",
      _ => toProtocol(protocol),
    },
    443 => switch (protocol) {
      Protocols.IPPROTO_UDP => "QUIC",
      Protocols.IPPROTO_TCP => "TLS",
      _ => toProtocol(protocol),
    },
    _ => toProtocol(protocol),
  };
}

class Protocols {
  static const int IPPROTO_IP = 0;
  static const int IPPROTO_ICMP = 1;
  static const int IPPROTO_IGMP = 2;
  static const int IPPROTO_IPIP = 4;
  static const int IPPROTO_TCP = 6;
  static const int IPPROTO_EGP = 8;
  static const int IPPROTO_PUP = 12;
  static const int IPPROTO_UDP = 17;
  static const int IPPROTO_IDP = 22;
  static const int IPPROTO_TP = 29;
  static const int IPPROTO_DCCP = 33;
  static const int IPPROTO_IPV6 = 41;
  static const int IPPROTO_ROUTING = 43;
  static const int IPPROTO_FRAGMENT = 44;
  static const int IPPROTO_RSVP = 46;
  static const int IPPROTO_GRE = 47;
  static const int IPPROTO_ESP = 50;
  static const int IPPROTO_AH = 51;
  static const int IPPROTO_ICMPV6 = 58;
  static const int IPPROTO_NONE = 59;
  static const int IPPROTO_DSTOPTS = 60;
  static const int IPPROTO_MTP = 92;
  static const int IPPROTO_BEETPH = 94;
  static const int IPPROTO_ENCAP = 98;
  static const int IPPROTO_PIM = 103;
  static const int IPPROTO_COMP = 108;
  static const int IPPROTO_L2TP = 115;
  static const int IPPROTO_SCTP = 132;
  static const int IPPROTO_MH = 135;
  static const int IPPROTO_UDPLITE = 136;
  static const int IPPROTO_MPLS = 137;
  static const int IPPROTO_ETHERNET = 143;
  static const int IPPROTO_RAW = 255;
  static const int IPPROTO_MPTCP = 262;
}
