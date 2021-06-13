// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_api_provider.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MovieApiProvider implements MovieApiProvider {
  _MovieApiProvider(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.themoviedb.org/3/movie';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ItemModel> fetchMovieList({apiKey}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api_key': apiKey};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/popular',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ItemModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<TrailerModel> fetchTrailer(movieId, {apiKey}) async {
    ArgumentError.checkNotNull(movieId, 'movieId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api_key': apiKey};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/$movieId/videos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TrailerModel.fromJson(_result.data);
    return value;
  }
}
