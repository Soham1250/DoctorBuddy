import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const BottomNavigation({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onPressed,
  }) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: isSelected ? 28 : 24,
                  color: isSelected ? Colors.black : Colors.grey.shade600,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.black : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavButton(
            icon: Icons.search,
            label: 'Search Patient',
            index: 0,
            onPressed: () => onTap(0),
          ),
          _buildNavButton(
            icon: Icons.history,
            label: 'History',
            index: 1,
            onPressed: () => onTap(1),
          ),
          _buildNavButton(
            icon: Icons.calendar_today,
            label: 'Make Appointment',
            index: 2,
            onPressed: () => onTap(2),
          ),
          _buildNavButton(
            icon: Icons.person_add,
            label: 'Add Patient',
            index: 3,
            onPressed: () => onTap(3),
          ),
        ],
      ),
    );
  }
}
