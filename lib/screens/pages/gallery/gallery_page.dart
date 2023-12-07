import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varnja_church/screens/home/cubit/posts_cubit.dart';

import '../../../utils/router.dart';

@RoutePage()
class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state.galleryData.isNotEmpty) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: state.galleryData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                      child: InkWell(
                    onTap: () {
                      context.read<PostsCubit>().fetchParticularGallery(state.galleryData[index].photoGalleriesIds);
                      //AutoTabsRouter.of(context).setActiveIndex(4);
                      AutoTabsRouter.of(context).navigate(ParticularGalleryRoute(galleryName: state.galleryData[index].title));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.galleryData[index].title,
                          style:
                              TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
                        ),
                        Text(
                          state.galleryData[index].id.toString(),
                          style:
                              TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
                        ),
                        Text(
                          "Click to see more",
                          style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,),
                        ),
                      ],
                    ),
                  ),),
                );
              },);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
