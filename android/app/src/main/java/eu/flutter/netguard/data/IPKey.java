package eu.flutter.netguard.data;

import androidx.annotation.NonNull;

import java.util.Objects;

import eu.flutter.netguard.network.Protocols;

public class IPKey {
        long version;
        long protocol;
        String saddr;
        long sport;
        String daddr;
        long dport;
        long uid;

        public IPKey(long version, long protocol, String saddr, long sport, String daddr, long dport, long uid) {
            this.version = version;
            this.protocol = protocol;
            this.saddr = saddr;
            this.sport = (protocol == Protocols.TCP || protocol == Protocols.UDP ? sport : 0);
            this.daddr = daddr;
            // Only TCP (6) and UDP (17) have port numbers
            this.dport = (protocol == Protocols.TCP || protocol == Protocols.UDP ? dport : 0);
            this.uid = uid;
        }

        public String getDaddr() { return daddr; }
        public long getUid() { return uid; }

        @Override
        public boolean equals(Object obj) {
            if (!(obj instanceof IPKey))
                return false;
            IPKey other = (IPKey) obj;
            return (this.version == other.version &&
                    this.protocol == other.protocol &&
                    this.daddr.equals(other.daddr) &&
                    this.dport == other.dport &&
                    this.uid == other.uid);
        }

        @Override
        public int hashCode() {
            return Objects.hash(version, protocol, daddr, dport, uid);
        }

    @NonNull
    @Override
    public String toString() {
        return "daddr:"+daddr+" dport:"+dport+" protocol:"+protocol+" version:"+ version;
    }
}
