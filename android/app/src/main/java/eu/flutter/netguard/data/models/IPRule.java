package eu.flutter.netguard.data.models;

public class IPRule {
    private IPKey key;
    private String name;
    private boolean block;
    private long time;
    private long ttl;

    public IPRule(IPKey key, String name, boolean block, long time, long ttl) {
        this.key = key;
        this.name = name;
        this.block = block;
        this.time = time;
        this.ttl = ttl;
    }

    public boolean isBlocked() {
        return this.block;
    }

    public boolean isExpired() {
        return System.currentTimeMillis() > (this.time + this.ttl * 2);
    }

    public void updateExpires(long time, long ttl) {
        this.time = time;
        this.ttl = ttl;
    }

    @Override
    public boolean equals(Object obj) {
        IPRule other = (IPRule) obj;
        return (this.block == other.block &&
                this.time == other.time &&
                this.ttl == other.ttl);
    }

    @Override
    public String toString() {
        return this.key + " " + this.name;
    }
}
