import 'package:flutter/material.dart';
import 'package:two_wheelers/templates/screens/home_screen.dart';

class ChatHead extends StatefulWidget {
  const ChatHead({super.key});

  @override
  State<ChatHead> createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHead> {
  final GlobalKey _key = GlobalKey();
  Size? floatingSize;
  Offset floationgLocation = const Offset(0, 100);

  //get size of floation button
  void getFloationSize() {
    RenderBox floationBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    floatingSize = floationBox.size;
    // setState(() {
    //   floatingSize = size;
    // });
  }

  void onDragUpdate(BuildContext context, DragUpdateDetails details) {
    // Gesture location
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);

    // Screen area
    const double startX = 0;
    final double endX = context.size!.width - floatingSize!.width;
    final double startY = MediaQuery.of(context).padding.top;
    final double endY = context.size!.height -
        floatingSize!.height -
        MediaQuery.of(context).padding.bottom;

    // Make sure widget always within the screen
    double dx = offset.dx;
    double dy = offset.dy;
    if (offset.dx < startX) {
      dx = startX;
    } else if (offset.dx > endX) {
      dx = endX;
    }
    if (offset.dy < startY) {
      dy = startY;
    } else if (offset.dy > endY) {
      dy = endY;
    }

    // Adjust dy if the button is partially or fully off the screen at the bottom
    if (dy + floatingSize!.height >
        context.size!.height - MediaQuery.of(context).padding.bottom) {
      dy = context.size!.height -
          floatingSize!.height -
          MediaQuery.of(context).padding.bottom;
    }

    setState(() {
      floationgLocation = Offset(dx, dy);
    });
  }

  // onDragUpdate(BuildContext context, DragUpdateDetails details) {
  //   //Gesture location
  //   final RenderBox box = context.findRenderObject() as RenderBox;
  //   final Offset offset = box.globalToLocal(details.globalPosition);

  //   //screen area
  //   const double startX = 0;
  //   final double endX = context.size!.width - floatingSize!.width;
  //   final double startY = MediaQuery.of(context).padding.top;
  //   final double endY = context.size!.height -
  //       floatingSize!.height -
  //       MediaQuery.of(context).padding.bottom;

  //   //male sure widget always with in the screen
  //   // if (startX < offset.dx && offset.dx < endX) {
  //   //   if (startY < offset.dy && offset.dy < endY) {
  //   //     setState(() {
  //   //       floationgLocation = Offset(offset.dx, offset.dy);
  //   //     });
  //   //   }
  //   // }
  //   double dx = offset.dx;
  //   double dy = offset.dy;
  //   if (offset.dx < startX) {
  //     dx = startX;
  //   } else if (offset.dx > endX) {
  //     dx = endX;
  //   }
  //   if (offset.dy < startY) {
  //     dy = startY;
  //   } else if (offset.dy > endY) {
  //     dy = endY;
  //   }

  //   setState(() {
  //     floationgLocation = Offset(dx, dy);
  //   });
  // }

  onDragEnd(BuildContext context, DragEndDetails details) {
    final double pointX = context.size!.width / 2;

    if (floationgLocation.dx < pointX) {
      setState(() {
        floationgLocation = Offset(0, floationgLocation.dy);
      });
    } else {
      setState(() {
        floationgLocation = Offset(
            context.size!.width - floatingSize!.width, floationgLocation.dy);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getFloationSize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Head'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          onDragUpdate(context, details);
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          onDragUpdate(context, details);
        },
        onVerticalDragEnd: (DragEndDetails details) {
          onDragEnd(context, details);
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          onDragEnd(context, details);
        },
        child: Stack(
          children: [
            Positioned(
              right: floationgLocation.dx,
              bottom: floationgLocation.dy,
              child: FloatingActionButton(
                key: _key,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  size: 40,
                  Icons.add_outlined,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
