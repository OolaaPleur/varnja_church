import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:varnja_church/data/models/particular_gallery.dart';

import '../../../constants/constants.dart';
import '../../../data/models/gallery.dart';
import '../../../data/models/timetable.dart';

class PostsState {
  // Define the properties of your state here
  // Example: List<Post> posts;
  // For simplicity, I'm using a simple boolean state
  final bool isLoading;
  final Map<String, String> timetableData;
  final List<Gallery> galleryData;
  final List<GalleryPhoto> particularGalleryData;

  PostsState({this.isLoading = false, required this.timetableData, required this.galleryData, required this.particularGalleryData});

  PostsState copyWith({bool? isLoading, Map<String, String>? timetableData, List<Gallery>? galleryData, List<GalleryPhoto>? particularGalleryData}) {
    return PostsState(
      isLoading: isLoading ?? this.isLoading,
      timetableData: timetableData ?? this.timetableData,
      galleryData: galleryData ?? this.galleryData,
      particularGalleryData: particularGalleryData ?? this.particularGalleryData,
    );
  }
}

class PostsCubit extends Cubit<PostsState> {
  PostsCubit()
      : super(
          PostsState(
            timetableData: {},
            galleryData: List<Gallery>.empty(),
            particularGalleryData: List<GalleryPhoto>.empty(),
          ),
        );

  Future<void> fetchSchedule() async {
    final response = await http.get(Uri.parse('http://localhost:1337/api/timetables?populate=localizations'), headers: strapiHeader);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final data = jsonData['data'] as List;
      if (data.isNotEmpty) {
        // Create a map to hold the schedules keyed by locale
        Map<String, String> schedules = {};

        for (var item in data) {
          // Extract the main schedule
          var mainAttributes = item['attributes'] as Map<String, dynamic>;
          var mainLocale = mainAttributes['locale'] as String;
          var mainSchedule = mainAttributes['schedule'] as String;
          schedules[mainLocale] = mainSchedule;

          // Extract the localizations
          var localizations = mainAttributes['localizations']['data'] as List;
          for (var localization in localizations) {
            var locAttributes = localization['attributes'] as Map<String, dynamic>;
            var locLocale = locAttributes['locale'] as String;
            var locSchedule = locAttributes['schedule'] as String;
            schedules[locLocale] = locSchedule;
          }
        }

        print(schedules);
        // Save the schedules map in the state
        emit(state.copyWith(timetableData: schedules));
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load timetables');
    }
  }


  Future<void> fetchGalleries() async {
    final response = await http.get(
        Uri.parse('http://localhost:1337/api/galleries?populate=photos'),
        headers: strapiHeader);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final data = jsonData['data'] as List;
      if (data.isNotEmpty) {
        // Assuming you want the first timetable entry

        final List<Gallery> galleries = data.map((item) {
          return Gallery.fromMap(item as Map<String, dynamic>);
        }).toList();

        emit(state.copyWith(galleryData: galleries));
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> fetchParticularGallery(List<int> photoGalleriesIds) async {
    final galleries = <GalleryPhoto>[];
    for (final id in photoGalleriesIds) {
      try {
        final response = await http.get(
          Uri.parse('http://localhost:1337/api/photos/$id?populate=*'),
          headers: strapiHeader,
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body) as Map<String, dynamic>;
          // Assuming 'data' is an object and not a list
          final data = jsonData['data'] as Map<String, dynamic>;
          galleries.addAll(GalleryPhoto.fromMap(data));
        } else {
          // Handle non-200 responses
          print('Failed to load photo with id $id');
        }
      } catch (e) {
        // Handle any exceptions
        print('Error fetching photo with id $id: $e');
      }
    }
    emit(state.copyWith(particularGalleryData: galleries));
  }

}
