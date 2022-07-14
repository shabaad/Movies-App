import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix/presentation/fast_laugh/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastlaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastlaughBloc, FastlaughState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (state.isError) {
              return Center(
                child: Text('Error getting data'),
              );
            } else if (state.videoList.isEmpty) {
              return Center(
                child: Text('video List Is Empty'),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(state.videoList.length, (index) {
                  return VideoListItemInheritedWidget(
                    widget: VideoListItem(
                      index: index,
                      key: Key(index.toString()),
                    ),
                    movieData: state.videoList[index],
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
