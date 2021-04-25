import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerObjects {
  Widget shimmerCountryChart() {
    return Shimmer.fromColors(
      child: Container(
        height: 218.4873949579832,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Colors.black12,
        ),
      ),
      baseColor: Colors.grey[700],
      highlightColor: Colors.grey[100],
    );
  }

  Widget shimmerHomePage() {
    return Shimmer.fromColors(
      child: Container(
        height: 140,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black12,
        ),
      ),
      baseColor: Colors.grey[700],
      highlightColor: Colors.grey[100],
    );
  }
}
