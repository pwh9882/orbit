import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

typedef OnDotClicked = void Function(int index);

class ReorderableSmoothPageIndicator extends StatefulWidget {
  final PageController controller;
  final BasicIndicatorEffect effect;
  final Axis axisDirection;
  final int count;
  final TextDirection? textDirection;
  final OnDotClicked? onDotClicked;

  const ReorderableSmoothPageIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
  });

  @override
  State<ReorderableSmoothPageIndicator> createState() =>
      _ReorderableSmoothPageIndicatorState();
}

mixin _SizeAndRotationCalculatorMixin {
  late Size size;
  int quarterTurns = 0;
  BuildContext get context;
  TextDirection? get textDirection;
  Axis get axisDirection;
  int get count;
  BasicIndicatorEffect get effect;

  void updateSizeAndRotation() {
    size = effect.calculateSize(count);
    final isRTL = (textDirection ?? _getDirectionality()) == TextDirection.rtl;
    if (axisDirection == Axis.vertical) {
      quarterTurns = 1;
    } else {
      quarterTurns = isRTL ? 2 : 0;
    }
  }

  TextDirection? _getDirectionality() {
    return context
        .findAncestorWidgetOfExactType<Directionality>()
        ?.textDirection;
  }
}

class _ReorderableSmoothPageIndicatorState
    extends State<ReorderableSmoothPageIndicator>
    with _SizeAndRotationCalculatorMixin {
  late List<int> _order;
  int? _draggingIndex;
  double _draggingOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _order = List.generate(widget.count, (index) => index);
    updateSizeAndRotation();
  }

  @override
  void didUpdateWidget(covariant ReorderableSmoothPageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateSizeAndRotation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _onLongPressStart,
      onLongPressMoveUpdate: _onLongPressMoveUpdate,
      onLongPressEnd: _onLongPressEnd,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) => SmoothIndicator(
          offset: _offset,
          count: count,
          effect: effect,
          onDotClicked: widget.onDotClicked,
          size: size,
          quarterTurns: quarterTurns,
          order: _order,
          draggingIndex: _draggingIndex,
          draggingOffset: _draggingOffset,
        ),
      ),
    );
  }

  void _onLongPressStart(LongPressStartDetails details) {
    final index = _hitTest(details.localPosition.dx);
    if (index != -1) {
      setState(() {
        _draggingIndex = index;
      });
    }
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    if (_draggingIndex != null) {
      setState(() {
        _draggingOffset = details.localPosition.dx;
        final newIndex = _hitTest(details.localPosition.dx);
        if (newIndex != -1 && newIndex != _draggingIndex) {
          final draggedItem = _order.removeAt(_draggingIndex!);
          _order.insert(newIndex, draggedItem);
          _draggingIndex = newIndex;
        }
      });
    }
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    setState(() {
      _draggingIndex = null;
      _draggingOffset = 0.0;
    });
  }

  int _hitTest(double dx) {
    final spacing = effect.spacing;
    for (int i = 0; i < _order.length; i++) {
      final start = i * (effect.dotWidth + spacing);
      final end = start + effect.dotWidth;
      if (dx >= start && dx <= end) {
        return i;
      }
    }
    return -1;
  }

  double get _offset {
    try {
      var offset =
          widget.controller.page ?? widget.controller.initialPage.toDouble();
      return offset % widget.count;
    } catch (_) {
      return widget.controller.initialPage.toDouble();
    }
  }

  @override
  int get count => widget.count;

  @override
  BasicIndicatorEffect get effect => widget.effect;

  @override
  Axis get axisDirection => widget.axisDirection;

  @override
  TextDirection? get textDirection => widget.textDirection;
}

class SmoothIndicator extends StatelessWidget {
  final double offset;
  final BasicIndicatorEffect effect;
  final int count;
  final OnDotClicked? onDotClicked;
  final Size size;
  final int quarterTurns;
  final List<int> order;
  final int? draggingIndex;
  final double draggingOffset;

  const SmoothIndicator({
    super.key,
    required this.offset,
    required this.count,
    required this.size,
    this.quarterTurns = 0,
    this.effect = const WormEffect(),
    this.onDotClicked,
    required this.order,
    this.draggingIndex,
    this.draggingOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: GestureDetector(
        onTapUp: _onTap,
        child: CustomPaint(
          size: size,
          painter: effect.buildPainter(count, offset),
        ),
      ),
    );
  }

  void _onTap(TapUpDetails details) {
    if (onDotClicked != null) {
      var index = effect.hitTestDots(details.localPosition.dx, count, offset);
      if (index != -1 && index != offset.toInt()) {
        onDotClicked?.call(index);
      }
    }
  }
}
