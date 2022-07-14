import 'package:flutter/cupertino.dart';
import 'package:netflix/core/constants.dart';

class MainCard extends StatelessWidget {
  final String imagrUrl;
  const MainCard({
    Key? key,
    required this.imagrUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: kRadius10,
        image: DecorationImage(
          image: NetworkImage(imagrUrl),
        ),
      ),
    );
  }
}
