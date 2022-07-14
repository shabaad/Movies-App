part of 'fastlaugh_bloc.dart';

@freezed
class FastlaughState with _$FastlaughState {
  const factory FastlaughState({
    @Default([]) List<Downloads> videoList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory FastlaughState.initial() => const FastlaughState(
        videoList: [],
        isLoading: false,
        isError: false,
      );
}
