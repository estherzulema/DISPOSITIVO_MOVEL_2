import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:istragaum/services/image_service.dart';
import 'package:istragaum/widgets/filter/filter_selector.dart';

class PreviewImage extends StatefulWidget {
  final XFile img;

  const PreviewImage({Key? key, required this.img}) : super(key: key);

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  final key = GlobalKey();

  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton.icon(
          style: TextButton.styleFrom(alignment: Alignment.centerLeft),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black,
          ),
          label: const Text(
            'Filtros',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: double.infinity,
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.check),
            onPressed: () async {
              double pixelRatio = MediaQuery.of(context).devicePixelRatio;
              final boundary = key.currentContext?.findRenderObject()
                  as RenderRepaintBoundary?;
              final image = await boundary?.toImage(pixelRatio: pixelRatio);
              final byteData =
                  await image?.toByteData(format: ImageByteFormat.png);
              final imgBytes = byteData?.buffer.asUint8List();

              ImageService service = ImageService();
              await service.saveImage(imgBytes);

              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              key: key,
              child: _buildPhotoWithFilter(widget.img),
            ),
          ),
          Positioned.fill(
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter(img) {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, value, child) {
        final color = value as Color;
        return Image.file(
          File(img.path),
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
