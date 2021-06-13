import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_blocApp/src/resources/urls.dart';
import 'package:retrofit/http.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';
part 'movie_api_provider.g.dart';


@RestApi(baseUrl: "https://api.themoviedb.org/3/movie")
abstract class MovieApiProvider {
  factory MovieApiProvider(Dio client, {String baseUrl}) = _MovieApiProvider;


  @GET(urls.movieList)
  Future<ItemModel> fetchMovieList(
      {
        @Query("api_key") String apiKey
      }
      );

  @GET("/{id}${urls.movieDetails}")
  Future<TrailerModel> fetchTrailer(
      @Path("id") int movieId,
      {
        @Query("api_key") String apiKey
      }
      );
}
