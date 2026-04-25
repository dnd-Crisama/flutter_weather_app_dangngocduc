import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onSearch;

  const ErrorWidgetCustom({
    super.key,
    required this.message,
    required this.onRetry,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              'Có lỗi xảy ra',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            if (onSearch != null) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: onSearch,
                icon: const Icon(Icons.search),
                label: const Text('Tìm kiếm thành phố'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
