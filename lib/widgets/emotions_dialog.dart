import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:non_linear_video/utils/constants.dart';

class EmotionsDialog extends StatelessWidget {
  final String? selectedEmotion;
  final Function(String) onTap;
  const EmotionsDialog({Key? key, this.selectedEmotion, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CupertinoColors.activeBlue.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        margin: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'How do you feel now?',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: OrientationBuilder(
                builder: (context, orientation) => GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: Constants.emotions.entries
                      .map((e) => GestureDetector(
                            onTap: () {
                              onTap(e.key);
                              Navigator.pop(context);
                            },
                            child: _EmotionWidget(
                              emotion: e.key,
                              emoji: e.value,
                              selected: e.key == selectedEmotion,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmotionWidget extends StatelessWidget {
  final String emotion;
  final String emoji;
  final bool selected;
  const _EmotionWidget(
      {Key? key,
      required this.emotion,
      required this.emoji,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFF86F03)
              : CupertinoColors.activeBlue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 4),
            Text(emotion,
                style: const TextStyle(fontSize: 16, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
