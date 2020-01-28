import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:random_number_fact/api/http_client.dart';
import 'package:random_number_fact/api/number_data_api.dart';
import 'package:random_number_fact/repository/number_data_repo.dart';
import 'package:random_number_fact/stores/number_data_store.dart';

import 'bloc/bloc_vm.dart';
import 'mobx_example.dart' as mobx;
import 'bloc_example.dart' as bloc;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: getHome());
  }
}

Widget getHome() {
  return Provider(
    create: (_) => NumberDataStore(
      NumberDataRepo(
        NumberDataApi(
          HttpClient.getInstance(),
        ),
      ),
    ),
    child: mobx.MyHomePage(title: 'MobX'),
  );

  // return BlocProvider(
  //   create: (_) => BlocVM(
  //     NumberDataRepo(
  //       NumberDataApi(
  //         HttpClient.getInstance(),
  //       ),
  //     ),
  //   ),
  //   child: bloc.MyHomePage(title: "BLoC"),
  // );
}
