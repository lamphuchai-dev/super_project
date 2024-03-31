import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:super_app/app/constants/gaps.dart';
import 'package:super_app/app/extensions/context_extension.dart';
import 'package:super_app/app/types.dart';
import 'package:super_app/models/models.dart';
import 'package:super_app/views/reader/cubit/reader_cubit.dart';
import 'package:super_app/widgets/widgets.dart';

import '../cubit/read_comic_cubit.dart';

part 'read_comic_page.dart';
part '../widgets/widgets.dart';
part '../widgets/list_image.dart';
part '../widgets/base_menu.dart';
part '../widgets/auto_scroll_menu.dart';
part '../widgets/comic_button.dart';
part '../widgets/chapters_drawer.dart';

class ReadComicView extends StatelessWidget {
  const ReadComicView({super.key});
  static const String routeName = '/read_comic_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReadComicCubit(readerCubit: context.read<ReaderCubit>())..onInit(),
      child: const ReadComicPage(),
    );
  }
}
