import 'package:flutter/material.dart';

class Indicador extends Decoration {
  final BuildContext context;

  const Indicador({
    required this.context
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(context: context);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final BuildContext context;

  _CustomBoxPainter({
    required this.context
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    final Path path = Path();

    path.addRRect(
      RRect.fromRectAndCorners(
        rect,
        //bottomRight: const Radius.circular(50),
        //bottomLeft: const Radius.circular(50),
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
      ),
    );

    paint.color = Theme.of(context).colorScheme.primaryContainer;
    paint.style = PaintingStyle.fill;

    canvas.drawShadow(path, Colors.grey, 0.5, true);
    canvas.drawPath(path, paint);
  }
}