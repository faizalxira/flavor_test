import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  return Column(
                    children: [
                      Text("App Name ${data?.appName ?? ''}"),
                      Text("Package Name ${data?.packageName ?? ''}"),
                      SizedBox(height: 24),
                      if ((data?.packageName ?? '').endsWith('.dev'))
                        Text(
                          "the app is dev so the api base url is $apiBaseUrlDev",
                        )
                      else
                        Text(
                          "the app is not dev so the api base url is $apiBaseUrlProd",
                        ),
                    ],
                  );
                }

                return Center(
                  child: CircleAvatar(),
                );
              },
            ),
            SizedBox(height: 24),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

const apiBaseUrlProd = "https://example.com/api";
const apiBaseUrlDev = "https://dev.example.com/api";

enum EnvironmentType {
  dev(apiBaseUrlDev),
  prod(apiBaseUrlProd);

  const EnvironmentType(this.apiBaseUrl);
  final String apiBaseUrl;
}
