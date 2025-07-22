package eu.flutter.netguard.data;

/*
    This file is part of NetGuard.

    NetGuard is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    NetGuard is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with NetGuard.  If not, see <http://www.gnu.org/licenses/>.

    Copyright 2015-2024 by Marcel Bokhorst (M66B)
*/

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteStatement;
import android.os.HandlerThread;

import eu.flutter.netguard.NativeBridge.*;

public class DatabaseHelper {
    private static final String TAG = "NetGuard.Database";

    // TODO: what is this and do I need it?
    private static HandlerThread hthread = null;
    static {
        hthread = new HandlerThread("DatabaseHelper");
        hthread.start();
    }

    private final SQLiteDatabase db;

    // TODO: maybe parse package rules directly from db here? depends on how many it will be...

    public DatabaseHelper(String dbPath){
        db = SQLiteDatabase.openDatabase(
                dbPath,
                null,
                SQLiteDatabase.OPEN_READONLY
        );

        prepareStatements();
    }

    private SQLiteStatement genericBlacklistContainsHost;
    private SQLiteStatement genericBlacklistContainsIp;
    private void prepareStatements(){
        String sql = "SELECT EXISTS(SELECT 1 FROM hosts_table WHERE rule_id = NULL and type = 'host' and target = ?)";
        genericBlacklistContainsHost = db.compileStatement(sql);

        sql = "SELECT EXISTS(SELECT 1 FROM hosts_table WHERE rule_id IS NULL and type = 'ip' and target = ?)";
        genericBlacklistContainsIp = db.compileStatement(sql);
    }

    public boolean genericBlacklistContainsHost(String domain){
        genericBlacklistContainsHost.bindString(1, domain);
        return genericBlacklistContainsHost.simpleQueryForLong() != 0;
    }
    public boolean genericBlacklistContainsIp(String ip){
        genericBlacklistContainsIp.bindString(1, ip);
        return genericBlacklistContainsIp.simpleQueryForLong() != 0;
    }

    private void addTargetToRule(Rule rule, String target, String hostType, boolean blockQuic){
        // if any of the rules defines to block Quic, it will be applied, ignoring the rules that do not block quic
        if(blockQuic) rule.setBlockQuic(true);
        switch (hostType){
            case "host":
                rule.getHosts().put(target, true);
                break;
            case "ip":
                rule.getIps().put(target, true);
                break;
        }
    }
    public Rule getPackageRule(String packageName){
        String sql = "SELECT r.package_name, r.type as rule_type, r.active, r.block_quic, h.target, h.type as host_type " +
                "FROM rules_table as r " +
                "LEFT JOIN hosts_table as h ON r.id = h.rule_id " +
                "WHERE r.active and r.package_name = ?";
        String[] args = new String[1];
        args[0] = packageName;
        Rule blacklist = ModelBuilder.Rule(packageName, RuleType.BLACKLIST);
        Rule whitelist = ModelBuilder.Rule(packageName, RuleType.WHITELIST);

        // parse results
        Cursor cursor = db.rawQuery(sql, args);
        while(cursor.moveToNext()) {
            String ruleType = cursor.getString(1);
            boolean blockQuic = 0 != cursor.getShort(3);
            String target = cursor.getString(4);
            String hostType = cursor.getString(5);
            switch (ruleType){
                case "whitelist":
                    addTargetToRule(whitelist, target, hostType, blockQuic);
                    break;
                case "blacklist":
                    addTargetToRule(blacklist, target, hostType, blockQuic);
                    break;
            }
        }
        cursor.close();

        // if whitelist exists, we only use the whitelist
        if(!(whitelist.getIps().isEmpty() && whitelist.getHosts().isEmpty())){
            return whitelist;
        }
        // otherwise, if blacklist exists, we use that
        if(!(blacklist.getIps().isEmpty() && blacklist.getHosts().isEmpty())){
            return blacklist;
        }
        return null;
    }

}
