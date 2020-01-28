import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:random_number_fact/bloc/bloc_vm.dart';
import 'package:random_number_fact/bloc/events.dart';
import 'package:random_number_fact/bloc/states.dart';

import 'models/number_data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final gKey = GlobalKey<ScaffoldState>();
  final logger = Logger();
  BlocVM _numberBloc;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((duration) {
    //   BlocListener<BlocVM, Status>(
    //     bloc: BlocProvider.of<BlocVM>(context),
    //     condition: (_, __) => true,
    //     listener: (_, __) {
    //       print("here 💯");
    //       showSnackBar();
    //     },
    //   );
    // });
  }

  @override
  void didChangeDependencies() {
    _numberBloc ??= BlocProvider.of<BlocVM>(context);
    BlocListener<BlocVM, Status>(
      bloc: _numberBloc,
      condition: (_, __) => true,
      listener: (ctx, __) {
        print("here 💯");
        showSnackBar();
      },
    );
    super.didChangeDependencies();
  }

  void showSnackBar() {
    gKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(_numberBloc.state.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: gKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<BlocVM, Status>(
        bloc: _numberBloc,
        listener: (_, __) => showSnackBar(),
        child: Center(
          child: BlocBuilder<BlocVM, Status>(
            bloc: _numberBloc,
            condition: (prevS, newS) => !(newS is Loading),
            builder: (_, state) {
              if (state is Initial)
                return Icon(Icons.account_box);
              else if (state is Loaded)
                return onLoaded(state.payload);
              else if (state is Error) return onError;
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder(
          bloc: _numberBloc,
          builder: (context, state) {
            return state is Loading
                ? onLoading
                : FloatingActionButton(
                    onPressed: () =>
                        _numberBloc.add(Update(Random().nextInt(100), 'math')),
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  );
          }),
    );
  }

  Widget get onLoading => CircularProgressIndicator();

  Widget get onError => Icon(Icons.error);

  Widget onLoaded(NumberData data) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                data.text,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Text(
              data.number.toString(),
              style: TextStyle(fontSize: 25, color: Colors.cyan),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
