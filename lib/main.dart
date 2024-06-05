import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penrose Tiling',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Penrose Tiling'),
          actions: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent, // Set background color to transparent if needed
              child: ClipOval(
                child: Image.asset(
                  'assets/image.jpg',
                  fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the circular area
                  width: 50, // Ensure width and height are set to the diameter of the CircleAvatar
                  height: 50,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PenroseTilingDemo(),
        ),
      ),
    );
  }
}

class PenroseTilingDemo extends StatefulWidget {
  @override
  _PenroseTilingDemoState createState() => _PenroseTilingDemoState();
}

class _PenroseTilingDemoState extends State<PenroseTilingDemo> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            painter: PenroseTilingPainter(scale: _scale),
            child: Center(),
          ),
        ),
        Slider(
          min: 0.5,
          max: 2.0,
          label: 'Scale: ${_scale.toStringAsFixed(1)}',
          value: _scale,
          onChanged: (value) {
            setState(() {
              _scale = value;
            });
          },
        ),
      ],
    );
  }
}

class PenroseTilingPainter extends CustomPainter {
  final double scale;

  PenroseTilingPainter({required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double width = size.width * scale;
    double height = size.height * scale;
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    final path = Path();
    final phi = (1 + sqrt(5)) / 2;
    final baseLength = width / 5;
    final angleIncrement = pi * 2 / phi;

    for (double angle = 0; angle < pi * 2; angle += angleIncrement) {
      final x1 = centerX + baseLength * cos(angle);
      final y1 = centerY + baseLength * sin(angle);
      final x2 = centerX + baseLength * cos(angle + angleIncrement);
      final y2 = centerY + baseLength * sin(angle + angleIncrement);

      path.moveTo(centerX, centerY);
      path.lineTo(x1, y1);
      path.lineTo(x2, y2);
      path.lineTo(centerX, centerY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PenroseTilingPainter oldDelegate) {
    return oldDelegate.scale != scale;
  }
}