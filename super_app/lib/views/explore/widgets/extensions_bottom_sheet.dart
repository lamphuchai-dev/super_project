part of "../view/explore_view.dart";

class ExtensionsBottomSheet extends StatelessWidget {
  const ExtensionsBottomSheet(
      {super.key,
      required this.extensions,
      required this.onSelected,
      required this.exceptionPrimary});
  final List<Extension> extensions;
  final ValueChanged<Extension> onSelected;
  final Extension exceptionPrimary;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTextTheme;
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: OrientationBuilder(
            builder: (context, orientation) {
              double initialChildSize = 0.3;
              if (orientation == Orientation.landscape) {
                initialChildSize = 0.6;
              }
              return DraggableScrollableSheet(
                initialChildSize: initialChildSize,
                maxChildSize: 0.7,
                minChildSize: 0.2,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12))),
                    child: NestedScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            automaticallyImplyLeading: true,
                            leading: const SizedBox(),
                            pinned: true,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: 40,
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 6,
                                    ),
                                  ),
                                ),
                                Gaps.hGap4,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Nguồn đã có",
                                        style: textTheme.titleMedium),
                                  ],
                                ),
                              ]),
                            ),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, RoutesName.extensions);
                                  },
                                  icon: const Icon(Icons.more_vert))
                            ],
                          )
                        ];
                      },
                      body: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: RawScrollbar(
                          controller: scrollController,
                          radius: const Radius.circular(8),
                          thumbColor: colorScheme.surface,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontalPadding),
                            child: GridView.builder(
                              itemCount: extensions.length,
                              controller: scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 60,
                                      mainAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                final ext = extensions[index];
                                return ExtensionCard(
                                  extension: ext,
                                  isPrimary: exceptionPrimary.metadata.source ==
                                      ext.metadata.source,
                                  onTap: () {
                                    if (exceptionPrimary.metadata.source !=
                                        ext.metadata.source) {
                                      onSelected.call(ext);
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ExtensionCard extends StatelessWidget {
  const ExtensionCard(
      {super.key,
      required this.extension,
      required this.onTap,
      this.isPrimary = false});
  final Extension extension;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTextTheme;
    final colorScheme = context.colorScheme;
    final uri = Uri.parse(extension.metadata.source!);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: isPrimary ? colorScheme.primaryContainer : null,
                  border: Border.all(
                      color: isPrimary
                          ? colorScheme.primary.withOpacity(0.7)
                          : colorScheme.primaryContainer),
                  borderRadius: Dimens.cardBookBorderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gaps.wGap8,
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconExtension(icon: extension.metadata.icon),
                  ),
                  Gaps.wGap8,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          extension.metadata.name!,
                          style: textTheme.titleMedium,
                        ),
                        Gaps.hGap4,
                        Text(
                          uri.host,
                          style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              height: 1),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Gaps.wGap4,
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )),
                child: Text(
                  extension.metadata.type!.name.toTitleCase(),
                  style: textTheme.labelSmall?.copyWith(fontSize: 8),
                ),
              )),
          if (extension.metadata.tag != null)
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                      color: colorScheme.error.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      )),
                  child: Text(
                    extension.metadata.tag!,
                    style: textTheme.labelSmall?.copyWith(fontSize: 8),
                  ),
                ))
        ],
      ),
    );
  }
}
