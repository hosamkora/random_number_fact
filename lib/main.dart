import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:random_number_fact/api/http_client.dart';
import 'package:random_number_fact/api/number_data_api.dart';
import 'package:random_number_fact/repository/number_data_repo.dart';
import 'package:random_number_fact/stores/number_data_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider(
        create: (_) => NumberDataStore(
          NumberDataRepo(
            NumberDataApi(
              HttpClient.getInstance(),
            ),
          ),
        ),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final gKey = GlobalKey<ScaffoldState>();
  final logger = Logger();
  NumberDataStore _numberModelStore;
  final reactions = List<ReactionDisposer>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      final rec = reaction(
        (_) => _numberModelStore.state,
        (req) => showSnackbar(),
      );
      reactions.add(rec);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _numberModelStore ??= Provider.of<NumberDataStore>(context, listen: false);
  }

  void showSnackbar() {
    gKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(_numberModelStore.state.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: gKey,
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(child: Observer(
        builder: (_) {
          switch (_numberModelStore.state) {
            case RequestState.loading:
              return onLoading;
            case RequestState.error:
              return onError;
            case RequestState.loaded:
              return onLoaded;
            default:
              return SizedBox.shrink();
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _numberModelStore.getTriviaData(Random().nextInt(100), 'math'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget get onLoading => CircularProgressIndicator();

  Widget get onError => Icon(Icons.error);

  Widget get onLoaded => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                _numberModelStore.fact,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Text(
              _numberModelStore.number.toString(),
              style: TextStyle(fontSize: 25, color: Colors.cyan),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    reactions.forEach((disposer) => disposer.call());
    super.dispose();
  }
}