import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:random_number_fact/api/http_client.dart';
import 'package:random_number_fact/api/number_data_api.dart';
import 'package:random_number_fact/play_ground.dart';
import 'package:random_number_fact/repository/number_data_repo.dart';
import 'package:random_number_fact/stores/number_data_store.dart';
import 'package:random_number_fact/utils/scr_uril.dart';

import 'bloc/bloc_vm.dart';
import 'mobx_example.dart' as mobx;
import 'bloc_example.dart' as bloc;

void main() {
  ScrUtil.init(width: 720, height: 1280);
  // ScrUtil.init();
  runApp(DevicePreview(builder: (context) {
    return MyApp();
  }));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
            locale: DevicePreview.of(context).locale, // <--- Add the locale
            builder: DevicePreview.appBuilder,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ConfigrationWidget(
              child: getPlayGround(),
            ));
      },
    );
  }
}

Widget getHome() {
  return Provider(
    create: (context) {
      return NumberDataStore(
        NumberDataRepo(
          NumberDataApi(
            HttpClient.getInstance(),
          ),
        ),
      );
    },
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

Widget getPlayGround() {
  return PlayGround();
}

class ConfigrationWidget extends StatelessWidget {
  final Widget child;

  const ConfigrationWidget({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1440, height: 2560);
    print('scale factor ctx : ${ScreenUtil.textScaleFactor}');
    return child;
  }
}
