import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../ai_compose/compose_result.dart';
import 'device_catalog.dart';

/// 裝置預覽：軟殼／透明殼切換、≥3 機型切換、免責聲明
class DevicePreviewPage extends StatefulWidget {
  const DevicePreviewPage({super.key, required this.result});

  final ComposeResult result;

  @override
  State<DevicePreviewPage> createState() => _DevicePreviewPageState();
}

class _DevicePreviewPageState extends State<DevicePreviewPage> {
  late PhoneDevice _device;
  CaseFinish _finish = CaseFinish.soft;

  static const _quickIds = ['iphone15', 'iphone16_pro', 'pixel9', 's24'];

  @override
  void initState() {
    super.initState();
    _device = DeviceCatalog.selectable.first;
  }

  List<PhoneDevice> get _quickDevices {
    final map = {for (final d in DeviceCatalog.selectable) d.id: d};
    return _quickIds.map((id) => map[id]).whereType<PhoneDevice>().toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final previewMaxH = (MediaQuery.sizeOf(context).height * 0.38).clamp(200.0, 360.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('裝置預覽'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(child: FreeBadge()),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 640,
                  maxHeight: constraints.maxHeight,
                ),
                child: ListView(
                  primary: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  children: [
                    Text(
                      '預覽僅供參考，不保證與實物完全一致',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: previewMaxH,
                      width: double.infinity,
                      child: _PhoneCasePreview(
                        result: widget.result,
                        finish: _finish,
                        device: _device,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('殼材', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    SegmentedButton<CaseFinish>(
                      segments: [
                        for (final f in CaseFinish.values)
                          ButtonSegment(value: f, label: Text(f.labelTw)),
                      ],
                      selected: {_finish},
                      onSelectionChanged: (s) => setState(() => _finish = s.first),
                    ),
                    const SizedBox(height: 16),
                    Text('快速切換機型', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final d in _quickDevices)
                          ChoiceChip(
                            label: Text(d.name),
                            selected: _device.id == d.id,
                            onSelected: (_) => setState(() => _device = d),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _device.id,
                      isExpanded: true,
                      decoration: const InputDecoration(labelText: '全部支援機型'),
                      items: [
                        for (final d in DeviceCatalog.all)
                          DropdownMenuItem(
                            value: d.id,
                            enabled: !d.comingSoon,
                            child: Text(
                              d.comingSoon
                                  ? '${d.displayName}（即將支援）'
                                  : d.displayName,
                              overflow: TextOverflow.ellipsis,
                              style: d.comingSoon
                                  ? TextStyle(color: scheme.outline)
                                  : null,
                            ),
                          ),
                      ],
                      onChanged: (id) {
                        if (id == null) return;
                        final d = DeviceCatalog.all.firstWhere((e) => e.id == id);
                        if (d.comingSoon) return;
                        setState(() => _device = d);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '清單外機型暫不支援。',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.vendor,
                          arguments: _device,
                        );
                      },
                      child: const Text('找客製廠商'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PhoneCasePreview extends StatelessWidget {
  const _PhoneCasePreview({
    required this.result,
    required this.finish,
    required this.device,
  });

  final ComposeResult result;
  final CaseFinish finish;
  final PhoneDevice device;

  @override
  Widget build(BuildContext context) {
    final borderColor = finish == CaseFinish.transparent
        ? Colors.white70
        : Colors.black87;
    final caseColor = finish == CaseFinish.transparent
        ? Colors.white.withValues(alpha: 0.35)
        : const Color(0xFF2D3436);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19,
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: caseColor,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: borderColor, width: 3),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 16,
                  offset: Offset(0, 8),
                  color: Color(0x33000000),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (result.imageBytes != null)
                    ColorFiltered(
                      colorFilter: result.filter,
                      child: Image.memory(
                        result.imageBytes!,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    CustomPaint(
                      painter: _PatternPainter(result.seedColor),
                    ),
                  if (result.promptText != null)
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          result.promptText!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            shadows: [
                              Shadow(blurRadius: 8, color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (result.imageBytes == null && result.promptText == null)
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          '示例圖案',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black87),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 12,
                    child: Column(
                      children: [
                        Text(
                          device.displayName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black54),
                            ],
                          ),
                        ),
                        Text(
                          '${finish.labelTw} · ${result.label}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  _PatternPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = color.withValues(alpha: 0.85);
    canvas.drawRect(Offset.zero & size, bg);
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (double y = -size.height; y < size.height * 2; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + size.width * 0.4), paint);
    }
    final circle = Paint()..color = Colors.white.withValues(alpha: 0.12);
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.3),
      size.width * 0.35,
      circle,
    );
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) =>
      oldDelegate.color != color;
}
