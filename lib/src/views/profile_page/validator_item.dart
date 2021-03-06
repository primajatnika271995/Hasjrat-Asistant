import 'package:flutter/material.dart';

class ValidationItem extends StatefulWidget {
  ValidationItem(this.title, this.valid);

  final String title;
  final bool valid;

  @override
  _ValidationItemState createState() => _ValidationItemState();
}

class _ValidationItemState extends State<ValidationItem>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _strikeController;
  Animation<double> _spaceWidth;
  Animation<double> _strikePercent;

  @override
  void didUpdateWidget(ValidationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valid != widget.valid) {
      if (widget.valid) {
        _playAnimation(true);
      } else {
        _playAnimation(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _strikeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _spaceWidth = Tween<double>(begin: 8, end: 12)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _strikePercent = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _strikeController, curve: Curves.easeOut));

    _spaceWidth.addListener(() {
      setState(() {});
    });

    _strikePercent.addListener(() {
      setState(() {});
    });
  }

  Future<void> _playAnimation(bool strikeIn) async {
    try {
      if (strikeIn) {
        _strikeController.forward().orCancel;
      } else {
        _strikeController.reverse().orCancel;
      }

      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: CustomPaint(
        foregroundPainter: StrikeThroughPainter(_strikePercent.value),
        child: Text(widget.title,
          style: _getValidateStyle(widget.valid),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  TextStyle _getValidateStyle(bool validation) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: (validation) ? Colors.black54 : Colors.black87,
      fontSize: 12,
      decoration: null,
    );
  }
}

class StrikeThroughPainter extends CustomPainter {
  StrikeThroughPainter(this.percent);

  double percent;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, (size.height / 2) - 2, size.width * percent, 4),
        Paint()..color = Colors.green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
