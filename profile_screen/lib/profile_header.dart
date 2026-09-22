import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String university;

  const ProfileHeader({
    required this.name,
    required this.university,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        ClipRRect(
          child: Image.asset('assets/images/me.jpg', width: 390, height: 340),
        ),
        const SizedBox(height: 20),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'ComicSans',
            color: colors.primary,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          university,
          style: TextStyle(
            fontFamily: 'Impact',
            color: colors.secondary,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
