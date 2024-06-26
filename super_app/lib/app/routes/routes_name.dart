import 'package:super_app/views/detail/detail.dart';
import 'package:super_app/views/explore/explore.dart';
import 'package:super_app/views/extensions/extensions.dart';
import 'package:super_app/views/home/home.dart';
import 'package:super_app/views/reader/reader.dart';
import 'package:super_app/views/search/search.dart';

class RoutesName {
  RoutesName._();
  static const init = "/";
  static const home = HomeView.routeName;
  static const explore = ExploreView.routeName;
  static const detail = DetailView.routeName;
  static const extensions = ExtensionsView.routeName;
  static const search = SearchView.routeName;
  static const reader = ReaderView.routeName;
}
