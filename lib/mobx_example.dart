import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:random_number_fact/api/http_client.dart';
import 'stores/number_data_store.dart';
import 'dart:ui' as ui;
import 'package:random_number_fact/utils/sizing_util.dart';

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
    HttpClient.enableLogging(true);
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
    return SafeArea(
      child: Scaffold(
        key: gKey,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 150.0.h),
          child: AppBar(
            title: Text(""),
          ),
        ),
        body: Center(child: Observer(
          builder: (_) {
            switch (_numberModelStore.state) {
              case RequestState.loading:
              case RequestState.loaded:
                return onLoaded;
              case RequestState.error:
                return onError;
              default:
                return SizedBox.shrink();
            }
          },
        )),
        floatingActionButton: SizedBox(
          width: 150.0.w,
          height: 150.0.h,
          child: Observer(builder: (context) {
            return _numberModelStore.state == RequestState.loading
                ? Center(child: onLoading)
                : FloatingActionButton(
                    onPressed: onTap,
                    tooltip: 'Increment',
                    child: Icon(
                      Icons.add,
                      size: 80.0.sp,
                    ),
                  );
          }),
        ),
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
                style: TextStyle(fontSize: 100.0.sp),
              ),
            ),
            Text(
              _numberModelStore.number.toString(),
              style: TextStyle(
                fontSize: 100.0.sp,
                color: Colors.cyan,
              ),
            ),
            Text(
              _numberModelStore.number.toString(),
              style: TextStyle(
                fontSize: 100.0.sp,
                color: Colors.cyan,
              ),
            ),
            Container(
              color: Colors.cyan,
              width: 200.0.w,
              height: 200.0.w,
              // width: 200,
              // height: 200,
            )
          ],
        ),
      );
  @override
  void dispose() {
    reactions.forEach((disposer) => disposer.call());
    super.dispose();
  }

  void onTap() {
    _numberModelStore.getTriviaData(Random().nextInt(100), 'math');
    final data = MediaQuery.of(context);
    debugPrint(" 👍👍👍👍 ${data.devicePixelRatio} 👎👎👎");
    debugPrint(" 👍👍👍 Logical lSize : ${data.size} 👎👎👎");
    debugPrint(" 👍👍👍 width : ${data.size.width} 👎👎👎");
    debugPrint(" 👍👍👍 height : ${data.size.height} 👎👎👎");
    debugPrint("Pixel Size: ${ui.window.physicalSize}");
    print((ui.window.physicalSize.width / ui.window.devicePixelRatio));
    print((ui.window.physicalSize.height / ui.window.devicePixelRatio));
    print(gKey.currentState.appBarMaxHeight);
    print("🖐🖐🖐🖐🖐🖐 ${ui.window.padding.top}");
    print("✋✋✋✋✋✋✋✋ ${data.padding.top}");
    print("uibr:${ui.window.platformBrightness.index}");
    print("${data.platformBrightness.index}");
    HttpClient.enableLogging(true);
  }
}
