part of '../view/read_comic_view.dart';

class BaseMenu extends StatelessWidget {
  const BaseMenu({super.key, required this.readComicCubit});
  final ReadComicCubit readComicCubit;

  @override
  Widget build(BuildContext context) {
    final colorBackground = context.colorScheme.primaryContainer;
    final textTheme = context.appTextTheme;
    return Stack(
      children: [
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AnimatedBuilder(
                animation: readComicCubit.getAnimationController!,
                builder: (context, child) => SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, -1), end: Offset.zero)
                          .animate(CurvedAnimation(
                              parent: readComicCubit.getAnimationController!,
                              curve: Curves.easeOutQuad)),
                      child: child,
                    ),
                child: Container(
                  // height: 120,
                  color: colorBackground,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SafeArea(
                      bottom: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ComicButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                colorBackground: colorBackground,
                                icon: const Icon(
                                  Icons.close,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              ComicButton(
                                onTap: () {
                                  // widget.watchComicCubit.onRefresh();
                                },
                                colorBackground: colorBackground,
                                icon: const Icon(
                                  Icons.refresh_rounded,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Gaps.wGap12,
                              ComicButton(
                                onTap: () {},
                                colorBackground: colorBackground,
                                icon: const Icon(
                                  Icons.swipe_down_alt_rounded,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Gaps.wGap12,
                              ComicButton(
                                onTap: () {
                                  // showModalBottomSheet(
                                  //     context: context,
                                  //     isScrollControlled: true,
                                  //     builder: (_) => SettingsWatchComic(
                                  //           watchComicCubit:
                                  //               widget.watchComicCubit,
                                  //         ));
                                },
                                colorBackground: colorBackground,
                                icon: const Icon(
                                  Icons.more_vert,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Gaps.hGap4,
                          GestureDetector(
                            onTap: () {
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   elevation: 0,
                              //   enableDrag: true,
                              //   clipBehavior: Clip.hardEdge,
                              //   backgroundColor: Colors.transparent,
                              //   builder: (context) => ChaptersBottomSheet(),
                              // );
                              Scaffold.of(context).openDrawer();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  readComicCubit.getBook.name ?? "",
                                  maxLines: 2,
                                  style: textTheme.bodyMedium,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                    Gaps.wGap4,
                                    Flexible(child:
                                        BlocBuilder<ReaderCubit, ReaderState>(
                                      builder: (context, state) {
                                        return Text(
                                          state.readCurrentChapter.data!.name ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodyMedium,
                                        );
                                      },
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gaps.hGap8
                        ],
                      )),
                ))),
        Align(
          alignment: Alignment.bottomRight,
          child: AnimatedBuilder(
            animation: readComicCubit.getAnimationController!,
            builder: (context, child) => SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(CurvedAnimation(
                          parent: readComicCubit.getAnimationController!,
                          curve: Curves.easeOutQuad)),
              child: child,
            ),
            child: Container(
              margin: EdgeInsets.only(right: 24, bottom: context.height * 0.1),
              width: 30,
              height: context.height * 0.7,
              child: Column(
                children: [
                  ComicButton(
                      colorBackground: colorBackground,
                      onTap: () {},
                      icon: const Icon(
                        Icons.north_rounded,
                        size: 16,
                        color: Colors.white,
                      )),
                  Gaps.hGap16,
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: colorBackground,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20))),
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 1,
                          onChanged: (value) {
                            // widget.watchComicCubit
                            //     .onChangeSliderScroll(value);
                          },
                        )

                        // child: ValueListenableBuilder(
                        //   valueListenable:
                        //       widget.watchComicCubit.progressWatchValue,
                        //   builder: (context, value, child) {
                        //     return Slider(
                        //       min: 0,
                        //       max: 100,
                        //       value: value?.percent.clamp(0, 100) ?? 0,
                        //       onChanged: (value) {
                        //         widget.watchComicCubit
                        //             .onChangeSliderScroll(value);
                        //       },
                        //     );
                        //   },
                        // ),
                        ),
                  )),
                  Gaps.hGap16,
                  ComicButton(
                      colorBackground: colorBackground,
                      onTap: () {},
                      icon: const Icon(
                        Icons.south_rounded,
                        size: 16,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}