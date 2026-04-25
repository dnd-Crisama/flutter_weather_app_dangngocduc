import 'package:flutter/material.dart';

// Hieu ung loading
class LoadingShimmer extends StatefulWidget {
  const LoadingShimmer({super.key});

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Tao mot thanh placeholder co mau xam mo dan
  Widget _shimmerBox({double width = double.infinity, double height = 20}) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Placeholder header
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(0),
            ),
            child: FadeTransition(
              opacity: _animation,
              child: Container(color: Colors.grey[300]),
            ),
          ),
          const SizedBox(height: 16),

          // Placeholder chi tiet
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 20, width: 100),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (_) {
                    return Column(
                      children: [
                        _shimmerBox(width: 48, height: 48),
                        const SizedBox(height: 6),
                        _shimmerBox(width: 60, height: 12),
                        const SizedBox(height: 4),
                        _shimmerBox(width: 40, height: 10),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),
                _shimmerBox(height: 20, width: 120),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: List.generate(5, (_) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: _shimmerBox(height: 100),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
