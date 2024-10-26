import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutMeSection extends StatelessWidget {
  final GlobalKey scrollKey;

  const AboutMeSection({
    super.key,
    required this.scrollKey,
  });

  @override
  Widget build(BuildContext context) {
    return _buildAboutMeSection(context);
  }

  Widget _buildAboutMeSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      key: scrollKey, // Using the passed key here
      color: colorScheme.surface,
      padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'About Me',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -30, end: 0),
          SizedBox(height: isDesktop ? 30 : 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return _buildDesktopLayout(context);
              } else {
                return _buildMobileLayout(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildProfileCard(context),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 2,
          child: _buildInfoCard(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileCard(context),
        const SizedBox(height: 20),
        _buildInfoCard(context),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/giphy (1).webp",
              width: isDesktop ? 200 : 150,
              height: isDesktop ? 200 : 150,
              fit: BoxFit.cover,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 600.ms)
              .slideY(begin: 50, end: 0)
              .animate()
              .scale(delay: 300.ms, duration: 600.ms),
          const SizedBox(height: 20),
          Text(
            'Dyari Ali Taher',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            '21 years old',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.8),
                ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 300.ms, duration: 600.ms)
        .slideY(begin: 50, end: 0);
  }

  Widget _buildInfoCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      padding: EdgeInsets.all(isDesktop ? 20 : 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello! I'm a passionate Computer Science student from Kurdistan, currently in my senior year at Knowledge University. My journey in the world of technology has been nothing short of exciting!",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 20),
          _buildSection(
            context,
            "🚀 My Expertise:",
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildExpertiseItem(context, "Web Development", Icons.web),
                _buildExpertiseItem(
                    context, "Mobile App Development", Icons.phone_android),
                _buildExpertiseItem(
                    context, "Windows App Development", Icons.desktop_windows),
              ],
            ),
          ),
          _buildSection(
            context,
            "🌟 Skills & Knowledge:",
            Text(
              "I've delved into algorithms, web development principles, computer applications, Firebase, MySQL, assembly, and artificial intelligence. My broad understanding of IT keeps me curious and always learning!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.5,
                  ),
            ),
          ),
          _buildSection(
            context,
            "🗣️ Languages:",
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildLanguageChip(context, "Kurdish (Native)"),
                _buildLanguageChip(context, "English (Fluent)"),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 600.ms, duration: 600.ms)
        .slideY(begin: 50, end: 0);
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
        ),
        const SizedBox(height: 10),
        content,
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildExpertiseItem(BuildContext context, String text, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 20),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(BuildContext context, String language) {
    final colorScheme = Theme.of(context).colorScheme;
    return Chip(
      label: Text(language),
      backgroundColor: colorScheme.primaryContainer,
      labelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
    );
  }
}
