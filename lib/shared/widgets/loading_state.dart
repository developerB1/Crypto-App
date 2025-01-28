import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingState extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const LoadingState({
    super.key,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.surfaceVariant,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class LoadingListState extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;

  const LoadingListState({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: LoadingState(height: itemHeight),
        );
      },
    );
  }
}

class LoadingGridState extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final double itemHeight;
  final double spacing;

  const LoadingGridState({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 6,
    this.itemHeight = 120,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return LoadingState(height: itemHeight);
      },
    );
  }
}

class LoadingDetailsState extends StatelessWidget {
  const LoadingDetailsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingState(height: 200),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: LoadingState(height: 60),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: LoadingState(height: 60),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const LoadingState(height: 100),
          const SizedBox(height: 16),
          const LoadingState(height: 100),
        ],
      ),
    );
  }
}
