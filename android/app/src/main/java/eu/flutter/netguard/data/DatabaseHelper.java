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
import android.os.Handler;
import android.os.Looper;


import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CountDownLatch;

import eu.flutter.netguard.utils.Log;
import eu.flutter.netguard.NativeBridge.*;

public class DatabaseHelper {
    private static final String TAG = "NetGuard.Database";

    // TODO: seems to crash sometimes...

    private final Handler queryHandler;
    private final SQLiteDatabase db;

    public DatabaseHelper(String dbPath){
        assert(new File(dbPath).canWrite());

        queryHandler = new Handler(Looper.getMainLooper());
        db = SQLiteDatabase.openDatabase(
                dbPath,
                null,
                SQLiteDatabase.OPEN_READONLY
        );

        // prepare SQLiteStatements
        String sql = "SELECT EXISTS(SELECT 1 FROM hosts_table WHERE rule_id IS NULL and type = 'host' and target = ?)";
        genericBlacklistContainsHost = db.compileStatement(sql);

        sql = "SELECT EXISTS(SELECT 1 FROM hosts_table WHERE rule_id IS NULL and type = 'ip' and target = ?)";
        genericBlacklistContainsIp = db.compileStatement(sql);

    }


    public void close(){
        db.close();
    }

    private final SQLiteStatement genericBlacklistContainsHost;
    private final SQLiteStatement genericBlacklistContainsIp;

    public boolean genericBlacklistContainsHost(String domain){
        Log.i(TAG, "Check BlacklistHost for "+domain);
        return runBlocking(() -> {
            synchronized (genericBlacklistContainsHost) {
                genericBlacklistContainsHost.clearBindings();
                genericBlacklistContainsHost.bindString(1, domain);
                return genericBlacklistContainsHost.simpleQueryForLong() != 0;
            }
        });
    }
    public boolean genericBlacklistContainsIp(String ip){
        return runBlocking(() ->{
            synchronized (genericBlacklistContainsIp) {
                genericBlacklistContainsIp.clearBindings();
                genericBlacklistContainsIp.bindString(1, ip);
                return genericBlacklistContainsIp.simpleQueryForLong() != 0;
            }
        });
    }

    public List<ApplicationSetting> getApplicationSettings(List<String> packageNames){
        String sql = "SELECT t.package_name, t.filter, t.block_all, t.block_quic FROM application_setting_table as t";
        List<ApplicationSetting> applicationSettings = new ArrayList<>();
        Cursor cursor = db.rawQuery(sql, null);
        while(cursor.moveToNext()){
            String packageName = cursor.getString(0);
            if(!packageNames.contains(packageName)) continue;
            applicationSettings.add(ModelBuilder.ApplicationSetting(
                    packageName,
                    cursor.getLong(1) != 0,
                    cursor.getLong(2) != 0,
                    cursor.getLong(3) != 0));
        }
        cursor.close();
        return applicationSettings;
    }

    private void addTargetToRule(Rule rule, String target, String hostType){
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
        String[] args = new String[1];
        args[0] = packageName;

        String sql = "SELECT r.package_name, r.type as rule_type, r.active, h.target, h.type as host_type " +
                "FROM rules_table as r " +
                "LEFT JOIN hosts_table as h ON r.id = h.rule_id " +
                "WHERE r.active and r.package_name = ?";

        Rule blacklist = ModelBuilder.Rule(packageName, RuleType.BLACKLIST);
        Rule whitelist = ModelBuilder.Rule(packageName, RuleType.WHITELIST);

        // parse results
        Cursor cursor = db.rawQuery(sql, args);
        while(cursor.moveToNext()) {
            String ruleType = cursor.getString(1);
            String target = cursor.getString(3);
            String hostType = cursor.getString(4);
            Rule rule;
            switch(ruleType){
                case "whitelist":
                    rule = whitelist;
                    break;
                case "blacklist":
                    rule = blacklist;
                    break;
                default:
                    continue;
            }
            if(target != null && hostType != null) addTargetToRule(rule, target, hostType);
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

    private interface QueryTask<T> {
        T run();
    }

    private <T> T runBlocking(QueryTask<T> task) {
        final Object[] result = new Object[1];
        final CountDownLatch latch = new CountDownLatch(1);

        queryHandler.post(() -> {
            result[0] = task.run();
            latch.countDown();
        });

        try {
            latch.await();
        } catch (InterruptedException e) {
            throw new RuntimeException("Blocking task was interrupted", e);
        }

        return (T) result[0];
    }

}
