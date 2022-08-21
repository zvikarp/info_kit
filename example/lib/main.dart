import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:info_kit/info_kit.dart';

void main() async {
  await InfoKit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        InfoKit.setConstrains(constraints);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Device Info',
                    style: Theme.of(context).textTheme.headline6),
                Text('Screen size: ${InfoKit.size.name}'),
                Text('Locale: ${InfoKit.locale.toLanguageTag()}'),
                Text('Platform: ${InfoKit.platform.name}'),
                Text('OS: ${InfoKit.os.name}'),
                Text('App Info', style: Theme.of(context).textTheme.headline6),
                Text('Origin: ${InfoKit.origin}'),
                Text('Flavor: ${InfoKit.flavor.name}'),
                Text('Mode: ${InfoKit.mode.name}'),
                Text('Build Info',
                    style: Theme.of(context).textTheme.headline6),
                Text('Build number: ${InfoKit.buildNumber}'),
                Text('Version: ${InfoKit.version}'),
                Text('Package name: ${InfoKit.packageName}'),
                Text('App name: ${InfoKit.appName}'),
                Text('Env', style: Theme.of(context).textTheme.headline6),
                Text('Env color: ${dotenv.get('COLOR')}'),
                Text('Env fruit: ${dotenv.get('FRUIT')}'),
                Text('Env drink: ${dotenv.get('DRINK')}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
