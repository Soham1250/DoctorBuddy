// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PagedDrawingCanvas extends StatefulWidget {
  final DrawingController controller;
  final Color backgroundColor;
  final String? placeholder;
  final Function(String)? onSavePDF;

  const PagedDrawingCanvas({
    Key? key,
    required this.controller,
    this.backgroundColor = Colors.white,
    this.placeholder,
    this.onSavePDF,
  }) : super(key: key);

  @override
  State<PagedDrawingCanvas> createState() => _PagedDrawingCanvasState();
}

class _PagedDrawingCanvasState extends State<PagedDrawingCanvas> {
  final List<DrawingController> _pageControllers = [];
  int _currentPage = 0;
  late double _pageHeight;
  bool _isGeneratingPDF = false;

  @override
  void initState() {
    super.initState();
    _pageControllers.add(widget.controller);
  }

  void _addNewPage() {
    final newController = DrawingController();
    setState(() {
      _pageControllers.add(newController);
      _currentPage = _pageControllers.length - 1;
    });
  }

  void _nextPage() {
    if (_currentPage < _pageControllers.length - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  Future<void> _generatePDF() async {
    if (_isGeneratingPDF) return;

    setState(() {
      _isGeneratingPDF = true;
    });

    try {
      final pdf = pw.Document();

      for (int i = 0; i < _pageControllers.length; i++) {
        final controller = _pageControllers[i];
        final imageData = await controller.getImageData();
        
        if (imageData != null) {
          final image = pw.MemoryImage(imageData as Uint8List);
          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(image, fit: pw.BoxFit.contain),
                );
              },
            ),
          );
        }
      }

      // Save PDF
      final directory = await getApplicationDocumentsDirectory();
      final String fileName =
          'drawing_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(await pdf.save());

      if (widget.onSavePDF != null) {
        widget.onSavePDF!(file.path);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to generate PDF. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPDF = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _pageHeight = constraints.maxHeight;

        return Stack(
          fit: StackFit.expand,
          children: [
            // Drawing Area
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: DrawingBoard(
                controller: _pageControllers[_currentPage],
                background: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: widget.backgroundColor,
                  child: _currentPage == 0 && widget.placeholder != null
                      ? Center(
                          child: Text(
                            widget.placeholder!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : null,
                ),
                showDefaultActions: true,
                showDefaultTools: true,
                boardScaleEnabled: false,
                boardPanEnabled: false,
                boardConstrained: false,
                minScale: 1.0,
                maxScale: 1.0,
              ),
            ),

            // Navigation Controls
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_currentPage > 0)
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 20),
                        onPressed: _previousPage,
                        tooltip: 'Previous Page',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${_currentPage + 1}/${_pageControllers.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    if (_currentPage < _pageControllers.length - 1)
                      IconButton(
                        icon: const Icon(Icons.arrow_forward, size: 20),
                        onPressed: _nextPage,
                        tooltip: 'Next Page',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, size: 20),
                      onPressed: _addNewPage,
                      tooltip: 'Add Page',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                    _isGeneratingPDF
                        ? const SizedBox(
                            width: 40,
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.check_circle, size: 20),
                            onPressed: _generatePDF,
                            tooltip: 'Done',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _pageControllers) {
      if (controller != widget.controller) {
        controller.dispose();
      }
    }
    super.dispose();
  }
}
