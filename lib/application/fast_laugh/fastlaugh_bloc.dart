import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/downloads.dart';
import 'package:netflix/domain/downloads/models/i_downloads_repo.dart';

part 'fastlaugh_event.dart';
part 'fastlaugh_state.dart';
part 'fastlaugh_bloc.freezed.dart';

final dummyVideoUrls = [
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
];

ValueNotifier<Set<int>> likedVideosIdNotifier = ValueNotifier({});

@injectable
class FastlaughBloc extends Bloc<FastlaughEvent, FastlaughState> {
  FastlaughBloc(
    IDownloadsRepo _downloadsService,
  ) : super(FastlaughState.initial()) {
    on<Initialize>((event, emit) async {
      //sending loadingn to UI
      emit(
        const FastlaughState(
          videoList: [],
          isLoading: false,
          isError: true,
        ),
      );
      // get trending movies
      final _result = await _downloadsService.getDownloadsImage();
      final _state = _result.fold(
          (l) => FastlaughState(
                videoList: [],
                isLoading: true,
                isError: false,
              ),
          (resp) => FastlaughState(
                videoList: resp,
                isLoading: false,
                isError: false,
              ));
      //send to UI

      emit(_state);
    });

    on<LikeVideo>((event, emit) {
      likedVideosIdNotifier.value.add(event.id);
    });

    on<UnLikeVideo>((event, emit) {
      likedVideosIdNotifier.value.remove(event.id);
    });
  }
}
