import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/ApiList.dart';

class ImageViewPage extends StatefulWidget {
  const ImageViewPage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage>
    with SingleTickerProviderStateMixin {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  OverlayEntry? entry;

  void resetAnimation() {
    animation = Matrix4Tween(
            begin: transformationController.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.bounceIn));
    animationController.forward(from: 0);
  }

  void showOVerlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    entry = OverlayEntry(builder: (context) {
      return Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy,
        child: buildImage(),
      );
    });
    final overLay = Overlay.of(context)!;
    overLay.insert(entry!);
  }

  void removeOverlay() {
    entry!.remove();
    entry = null;
  }

  @override
  void initState() {
    super.initState();
    transformationController = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )
      ..addListener(() => transformationController.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    transformationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Image'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: buildImage(),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Builder(
      builder: (context) => InteractiveViewer(
        transformationController: transformationController,
        clipBehavior: Clip.none,
        minScale: 1,
        maxScale: 4,
        panEnabled: false,
        onInteractionStart: (details) {
          if (details.pointerCount < 2) return;
          showOVerlay(context);
        },
        onInteractionEnd: (details) {
          resetAnimation();
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
