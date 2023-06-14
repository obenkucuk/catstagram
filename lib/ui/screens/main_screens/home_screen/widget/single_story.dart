import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../theme/app_colors.dart';

/// single story widget for the home screen
class SingleStory extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final bool isSeen;
  const SingleStory({super.key, required this.isSeen, this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorsX.paleTextLightTheme,
              gradient: !isSeen ? LinearGradient(colors: [Colors.yellow.shade600, Colors.orange, Colors.red]) : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(isSeen ? 2.0 : 3.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              name ?? '--------',
              style: s12W400(context),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
