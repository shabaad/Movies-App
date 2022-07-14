import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                print(direction);
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      // if (state.isLoading) {
                      //   return const Center(
                      //     child: CircularProgressIndicator(strokeWidth: 2),
                      //   );
                      // } else if (state.hasError) {
                      //   return const Center(
                      //       child: Text(
                      //     'Error while getting data',
                      //     style: TextStyle(color: Colors.white),
                      //   ));
                      // }
                      // released past year
                      final _releasedPastYear =
                          state.pastYearMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      //trending
                      final _trending = state.pastYearMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      //tense dramas
                      final _tenseDramas = state.pastYearMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      //southindian
                      final _southIndian = state.pastYearMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();
                      //_southIndian.shuffle();

                      //top 10 tv shows
                      final _top10TvShow = state.trendingTvList.map((t) {
                        return '$imageAppendUrl${t.posterPath}';
                      }).toList();
                      // _top10TvShow.shuffle();

                      //listview
                      return ListView(
                        children: [
                          BackgroundCard(),
                          MainTitleCard(
                            title: "Released in the Past Year",
                            posterList: _releasedPastYear.sublist(0, 10),
                          ),
                          kHeight,
                          MainTitleCard(
                            title: "Trending Now",
                            posterList: _trending.sublist(0, 10),
                          ),
                          kHeight,
                          NumberTitleCard(
                            postersList: _top10TvShow.sublist(0, 10),
                          ),
                          kHeight,
                          MainTitleCard(
                            title: "Tense Dramas",
                            posterList: _tenseDramas.sublist(0, 10),
                          ),
                          kHeight,
                          MainTitleCard(
                            title: "South Indian Cinema",
                            posterList: _southIndian.sublist(0, 10),
                          ),
                        ],
                      );
                    },
                  ),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 90,
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    "https://cdn.vox-cdn.com/thumbor/lfpXTYMyJpDlMevYNh0PfJu3M6Q=/39x0:3111x2048/920x613/filters:focal(39x0:3111x2048):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/49901753/netflixlogo.0.0.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.cast,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  kWidth,
                                  Container(
                                    width: 40,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  kWidth,
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "TV Shows",
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    "Movies",
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    "Categories",
                                    style: kHomeTitleText,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : kHeight,
                ],
              ),
            );
          }),
    );
  }
}
