import 'package:flutter/material.dart';

class AuthSplitLayout extends StatelessWidget {
  final int imageFlex;
  final int formFlex;
  final Widget form;
  final String imageAsset;
  final bool formOnLeft; // NEW

  const AuthSplitLayout({
    super.key,
    required this.imageFlex,
    required this.formFlex,
    required this.form,
    required this.imageAsset,
    this.formOnLeft = false, // default: image left
  });

  @override
  Widget build(BuildContext context) {
    final children = formOnLeft
        ? [
      Expanded(flex: formFlex, child: _buildForm()),
      Expanded(flex: imageFlex, child: _buildImage()),
    ]
        : [
      Expanded(flex: imageFlex, child: _buildImage()),
      Expanded(flex: formFlex, child: _buildForm()),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(children: children),
    );
  }

  Widget _buildForm() => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: form,
      ),
    ),
  );

  Widget _buildImage() => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imageAsset),
        fit: BoxFit.contain,
      ),
    ),
  );
}