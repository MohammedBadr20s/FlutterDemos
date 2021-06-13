import 'dart:async';

import 'package:dio/dio.dart';

import 'movie_api_provider.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';


class Repository {
  final MovieApiProvider moviesApiProvider;
  final String apiKey;

  Repository({this.moviesApiProvider, this.apiKey});
  
  
  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList(apiKey: apiKey);

  Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId,apiKey: apiKey);

}