import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:movie_app/view_models/home_view_model.dart';

class TabButtonWidget extends StatelessWidget {
  const TabButtonWidget({
    super.key,
    required this.index,
    required this.label,
    required this.viewModel,
  });

  final int index;
  final String label;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final isSelected = viewModel.currentTabIndex == index;
    return GestureDetector(
      onTap: () {
        viewModel.setCurrentTabIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3498DB) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          gradient:
              isSelected
                  ? const LinearGradient(
                    colors: [Color(0xFF0E9FF3), Color(0xFF094B96)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                  : null,
          border:
              isSelected
                  ? const GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: [Color(0xFF005BB0), Color(0xFF0084FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  )
                  : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
