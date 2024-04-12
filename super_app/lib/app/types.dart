// ignore_for_file: constant_identifier_names

import 'package:super_app/app/extensions/string_extension.dart';

enum StatusType { none, init, loading, loaded, error }

enum MediaStatus { init, start, pause, complete, stop, error }

enum ExtensionType { comic, novel, movie, all }

enum SortChapterType { newChapter, lastChapter }

enum ExtensionStatus { init, ready, unknown, error }

enum AutoScrollStatus { noActive, active, pause, complete }

enum DownloadStatus {
  waiting,
  downloading,
  downloaded,
  downloadedCancel,
  downloadErr
}

extension ExtensionTypeExt on ExtensionType {
  String get title => name.toTitleCase;
}
