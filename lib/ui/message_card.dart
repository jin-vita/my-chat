import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.message,
    required this.time,
    this.isRead = true,
  }) : super(key: key);
  final String message;
  final String time;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 80,
        ),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          color: const Color(0xffdcf8c6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Transform.translate(
                  offset: const Offset(-28, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 3),
                        child: Text(
                          isRead ? '' : '1',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.yellow,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 1,
                              ),
                              Shadow(
                                color: Colors.white,
                                blurRadius: 2,
                              ),
                              Shadow(
                                color: Colors.grey,
                                blurRadius: 3,
                              ),
                              Shadow(
                                color: Colors.black,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                            ),
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white,
                              blurRadius: 8,
                            ),
                            Shadow(
                              color: Colors.white,
                              blurRadius: 10,
                            ),
                            Shadow(
                              color: Colors.white,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
