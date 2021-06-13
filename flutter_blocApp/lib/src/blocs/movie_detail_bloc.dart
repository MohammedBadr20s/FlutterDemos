import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_blocApp/src/di/injection.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resources/repository.dart';
import 'bloc_base.dart';

class MovieDetailBloc extends BlocBase {
  final Repository repository;
  PublishSubject<int> _movieId;
  BehaviorSubject<Future<TrailerModel>> _trailers;

  MovieDetailBloc({this.repository});


  Function(int) get fetchTrailersById => _movieId.sink.add;
  Stream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  init(){
    _movieId = PublishSubject<int>();
    _trailers = BehaviorSubject<Future<TrailerModel>>();
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
          (Future<TrailerModel> trailer, int id, int index) {
        trailer = repository.fetchTrailers(id).catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioError:
            // Here's the sample to get the failed response error code and message
              final res = (obj as DioError);
              _movieId.sink.addError(res);
              logger.e("Got error : ${res.response.statusCode} -> ${res.response.statusMessage}");
              break;
            default:
          }
        });
        return trailer;
      },
    );
  }
}