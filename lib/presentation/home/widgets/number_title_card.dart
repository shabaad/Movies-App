import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widgets/main_title.dart';

import 'number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
    required this.postersList,
  }) : super(key: key);

  final List<String> postersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(
          title: "Top  10 TV shows in India Today",
        ),
        kHeight20,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              postersList.length,
              (index) => NumberCard(
                index: index,
                imageUrl: postersList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
