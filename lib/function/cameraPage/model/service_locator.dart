
import 'package:get_it/get_it.dart';
import 'package:plack/function/cameraPage/model/theme_view_model.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static init() {
    getIt.registerSingleton<ThemeViewModel>(ThemeViewModel());
  }

  static T get<T extends Object>() {
    return getIt.get<T>();
  }
}
