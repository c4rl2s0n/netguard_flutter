import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netguard/data/extensions/packet.dart';
import 'package:netguard/native_bridge.g.dart';
import 'package:netguard/data/models/vpn_settings.g.dart' as settings;
import 'package:netguard/vpn_event_channel.dart';
import 'package:netguard/vpn_event_handler.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool vpnRunning = false;

  VpnController vpnApi = VpnController();
  late VpnEventHandlerImpl eventHandler;

  @override
  void initState() {
    super.initState();
    eventHandler = VpnEventHandlerImpl();
    VpnEventHandler.setUp(eventHandler);
  }

  Future _toggleVpn() async {
    var _ = switch (vpnRunning) {
      false => await vpnApi.startVpn(VpnSettings(blockTraffic: true)),
      true => await vpnApi.stopVpn(),
    };
    setState(() {
      vpnRunning = !vpnRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Hello VPN'),
            _logs(context),
            _packetList(context),
            Text(
              vpnRunning ? "ON" : "OFF",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleVpn,
        tooltip: 'Toggle VPN',
        child: const Icon(Icons.network_check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _logs(BuildContext context){
    return StreamBuilder(stream: eventHandler.logs, builder: (context, data) {
      if(data.hasError) return Text("ERROR");
      if(data.hasData) return Text(data.requireData);
      return Text("Weiß auch nicht...");
    });
  }
  Widget _packetList(BuildContext context){
    return StreamBuilder(stream: eventHandler.packets, builder: (context, data) {
      if(data.hasError) return Text("ERROR");
      if(data.hasData) return Text(data.requireData.string);
      return Text("Weiß auch nicht...");
    });
  }
}
