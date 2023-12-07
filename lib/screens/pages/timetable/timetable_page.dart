import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varnja_church/constants/constants.dart';
import 'package:varnja_church/screens/home/cubit/posts_cubit.dart';
import 'package:varnja_church/screens/settings/language_cubit/language_cubit.dart';

@RoutePage()
class TimetablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocConsumer<LanguageCubit, Locale>(
            listener: (context, languageState) {
              // This is where you can react to state changes in LanguageCubit
              // For example, you might want to fetch new data based on the selected language
            },
            builder: (context, languageState) {
              return BlocBuilder<PostsCubit, PostsState>(
                builder: (context, postsState) {
                  print(postsState.timetableData);
                  if (postsState.timetableData.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(postsState.timetableData[languageState.toString()] ?? 'No data for this language'),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            },
          )

        ],
      ),
    );
  }
}
