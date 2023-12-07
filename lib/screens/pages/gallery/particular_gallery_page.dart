import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/cubit/posts_cubit.dart';

@RoutePage()
class ParticularGalleryPage extends StatelessWidget {
  const ParticularGalleryPage(@PathParam('galleryName') this.galleryName, {super.key});

  final String galleryName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state.particularGalleryData.isNotEmpty) {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: IconButton(
                      onPressed: () {
                        AutoTabsRouter.of(context).setActiveIndex(2);
                      },
                      icon: Center(child: Icon(Icons.arrow_back_ios)),
                      alignment: Alignment.center,
                      iconSize: 40,
                    ),
                  )
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: state.particularGalleryData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showImageGalleryOverlay(
                                  context,
                                  state.particularGalleryData.map((item) => item.url).toList(),
                                  index,
                                );
                              },
                              child: Image.network(state.particularGalleryData[index].url),
                            ),
                            Text(
                              state.particularGalleryData[index].caption,
                              style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void showImageGalleryOverlay(BuildContext context, List<String> imageUrls, int initialIndex) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        var currentIndex = initialIndex;
        final pageController = PageController(initialPage: initialIndex);
        final FocusNode focusNode = FocusNode();

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              // This will pop the dialog when tapping outside the dialog area.
              behavior: HitTestBehavior.translucent,
              child: KeyboardListener(
                autofocus: true,
                focusNode: focusNode,
                onKeyEvent: (event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                      nextPage(pageController);
                      print(event.logicalKey.keyLabel);
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                      previousPage(pageController);
                      print(event.logicalKey.keyLabel);
                    }
                  }
                },
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(10),
                  elevation: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {},
                                child: Center(child: Image.network(imageUrls[index])));
                          },
                          onPageChanged: (index) {
                            setState(
                                () => currentIndex = index); // Update currentIndex within the state
                          },
                        ),
                      ),
                      // Close Button
                      Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.redAccent),
                          iconSize: 50,
                          onPressed: () => Navigator.of(dialogContext).pop(),
                        ),
                      ),
                      // Next Button
                      Positioned(
                        right: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                          onPressed: currentIndex < imageUrls.length - 1
                              ? () {
                                  nextImage(pageController);
                                }
                              : null, // Disable button when on the last image
                        ),
                      ),
                      // Previous Button
                      Positioned(
                        left: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: currentIndex > 0
                              ? () {
                            previousPage(pageController);
                                }
                              : null, // Disable button when on the first image
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> previousPage(PageController pageController) {
    return pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
  }

  Future<void> nextPage(PageController pageController) {
    return pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
  }

  void nextImage(PageController pageController) {
    nextPage(pageController);
  }
}
