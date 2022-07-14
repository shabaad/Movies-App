import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hotandnew_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:netflix/presentation/widgets/video_widgets.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            title: Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              Icon(
                Icons.cast,
                color: Colors.white,
                size: 30,
              ),
              kWidth,
              Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              ),
              kWidth,
            ],
            bottom: TabBar(
              labelColor: kBlackColor,
              unselectedLabelColor: kWhiteColor,
              isScrollable: true,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              indicator:
                  BoxDecoration(color: kWhiteColor, borderRadius: kRadius30),
              tabs: const [
                Tab(
                  text: "🍿Coming Soon",
                ),
                Tab(
                  text: "👀Everyone's Watching",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingSoonList(
              key: Key('coming_soon'),
            ),
            EveryoneIsWatchingList(
              key: Key('everyone_is_watching'),
            ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotandnewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading coming soon list'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('Coming soon list is empty'),
            );
          } else {
            return ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formattedDate =
                      DateFormat.yMMMMd('en_US').format(_date);
                  return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: formattedDate
                        .split(' ')
                        .first
                        .substring(0, 3)
                        .toUpperCase(),
                    day: movie.releaseDate!.split('-')[1],
                    posterPath: "$imageAppendUrl${movie.posterPath}",
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No description',
                  );
                });
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotandnewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading Everyones watching list'),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('Everyones watching list is empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.everyOneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final tv = state.everyOneIsWatchingList[index];
                  if (tv.id == null) {
                    return const SizedBox();
                  }
                  return EveryonesWatchingWidget(
                      posterPath: "$imageAppendUrl${tv.posterPath}",
                      movieName: tv.originalName ?? 'No name provided',
                      description: tv.overview ?? 'No description');
                });
          }
        },
      ),
    );
  }
}
