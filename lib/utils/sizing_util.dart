import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_number_fact/utils/scr_uril.dart';

extension SizingUtil<T extends num> on T {
  T get width {
    return ScrUtil()?.setWidth(this);
  }

  T get height {
    return ScrUtil()?.setHeight(this);
  }

  T get sps {
    return ScrUtil()?.setSp(this);
  }
}

extension SizingUtil2<T extends num> on T {
  T get w {
    return ScreenUtil()?.setWidth(this);
  }

  T get h {
    return ScreenUtil()?.setHeight(this);
  }

  T get sp {
    return ScreenUtil()?.setSp(this);
  }

  T wp(double factor) => ScreenUtil()?.setWidth(this) * factor;

  T hp(double factor) => ScreenUtil()?.setHeight(this) * factor;
}
