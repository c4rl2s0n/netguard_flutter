package eu.flutter.netguard.data.models;

public class IPKey {
    long version;
    long protocol;
    long dport;
    long uid;

    public IPKey(long version, long protocol, long dport, long uid) {
        this.version = version;
        this.protocol = protocol;
        // Only TCP (6) and UDP (17) have port numbers
        this.dport = (protocol == 6 || protocol == 17 ? dport : 0);
        this.uid = uid;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof IPKey))
            return false;
        IPKey other = (IPKey) obj;
        return (this.version == other.version &&
                this.protocol == other.protocol &&
                this.dport == other.dport &&
                this.uid == other.uid);
    }

    @Override
    public int hashCode() {
        return (int)((version << 40) | (protocol << 32) | (dport << 16) | uid);
    }

    @Override
    public String toString() {
        return "v" + version + " p" + protocol + " port=" + dport + " uid=" + uid;
    }
}
