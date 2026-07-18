import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // const primaryColor = Color(0xFF4F46E5);
    const backgroundColor = Colors.white;

    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _UploadHeader(),
              SizedBox(height: 24),
              _UploadBox(),
              SizedBox(height: 24),
              _UploadingSection(),
              SizedBox(height: 24),
              _UploadedSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadHeader extends StatelessWidget {
  const _UploadHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Upload File",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  const _UploadBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4FF), width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_upload_outlined,
            size: 48,
            color: Color(0xFF4F46E5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Drag & drop files or Browse',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Supported formats: JPEG, PNG, GIF, MP4, PDF, PSD, AI, Word, PPT",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(221, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadingSection extends StatelessWidget {
  const _UploadingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Uploading - 3/3 files',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'your-file-name.PDF',
                    style: TextStyle(fontSize: 14, color: Colors.black38),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.7,
                  backgroundColor: Color(0xFFE0E0FF),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                  minHeight: 5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UploadedSection extends StatelessWidget {
  const _UploadedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // بۆ ئەوەی دوگمەکە پان ببێتەوە
      children: [
        // تێکستی بەشی Uploaded
        const Text(
          "Uploaded",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 12),

        // فایلی یەکەم (document-name.PDF)
        _buildFileItem("document-name.PDF"),
        const SizedBox(height: 8),

        // فایلی دووەم (image-name-goes-here.png)
        _buildFileItem("image-name-goes-here.png"),
        const SizedBox(height: 32), // بۆشایی پێش دوگمەکە
        // 🎯 دوگمەی کۆتایی (UPLOAD FILES)
        SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(
                0xFF4F46E5,
              ), // هەمان ڕەنگی مۆری سەرەکی
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "UPLOAD FILES",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🛠️ ئەمە مێسۆدێکی پرۆفیشناڵە بۆ دروستکردنی نەخشەی چوارچێوەی فایلەکان بەبێ ئەوەی کۆدەکە دووبارە بکەینەوە
  Widget _buildFileItem(String fileName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF22C55E),
          width: 1,
        ), // چوارچێوەی سەوز وەک دیزاینەکە
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fileName,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const Icon(
            Icons.check_circle_outline,
            size: 18,
            color: Color(0xFF22C55E),
          ), // ئەیکۆنی ڕاستی سەوز
        ],
      ),
    );
  }
}
