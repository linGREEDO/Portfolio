import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillSection extends StatelessWidget {
  final GlobalKey scrollKey;
  const SkillSection({super.key, required this.scrollKey});

  @override
  Widget build(BuildContext context) {
    return _buildSkillsSection(context);
  }

  Widget _buildSkillsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 900;
    final isTablet = screenSize.width >= 600 && screenSize.width < 900;

    return Container(
      key: scrollKey,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
              'assets/images/tumblr_eccb7edddaba09d76503723dd331b882_98fee8c0_540.webp'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            colorScheme.shadow.withOpacity(0.1),
            BlendMode.darken,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? 80
              : isTablet
                  ? 40
                  : 20,
          vertical: isDesktop ? 80 : 40,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface.withOpacity(0.9),
              colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            Text(
              'Programming Skills',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: isDesktop
                    ? 48
                    : isTablet
                        ? 40
                        : 32,
                shadows: [
                  Shadow(
                    color: colorScheme.shadow.withOpacity(0.3),
                    blurRadius: 3,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -30, end: 0),
            SizedBox(height: isDesktop ? 60 : 40),
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: isDesktop ? 30 : 20,
                  runSpacing: isDesktop ? 30 : 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildSkillCard(
                      context,
                      'Flutter',
                      'Full-Stack Development',
                      ['Dart', 'Firebase', 'Bloc', 'REST APIs'],
                      Icons.flutter_dash_outlined,
                      constraints,
                    ),
                    _buildSkillCard(
                      context,
                      'Java',
                      'Backend Development',
                      ['Spring Boot', 'MySQL'],
                      Icons.code,
                      constraints,
                    ),
                    _buildSkillCard(
                      context,
                      'C#',
                      'Desktop/Backend Development',
                      ['ASP.NET', 'Entity Framework', 'SQL Server'],
                      Icons.computer,
                      constraints,
                    ),
                    _buildSkillCard(
                      context,
                      'PHP',
                      'Backend Development',
                      ['MySQL'],
                      Icons.computer,
                      constraints,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(
    BuildContext context,
    String skill,
    String category,
    List<String> tools,
    IconData icon,
    BoxConstraints constraints,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 900;
    final isTablet = screenSize.width >= 600 && screenSize.width < 900;

    // Calculate card width based on container width
    double cardWidth;
    if (isDesktop) {
      cardWidth = constraints.maxWidth * 0.23; // 4 cards per row
    } else if (isTablet) {
      cardWidth = constraints.maxWidth * 0.45; // 2 cards per row
    } else {
      cardWidth = constraints.maxWidth; // 1 card per row
    }

    // Ensure minimum and maximum widths
    cardWidth = cardWidth.clamp(280.0, 400.0);

    return Card(
      elevation: 4,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.1),
          width: 1,
        ),
      ),
      color: colorScheme.surface.withOpacity(0.9),
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(isDesktop ? 30 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: isDesktop ? 48 : 40,
                  color: colorScheme.primary,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              category,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            ...tools.map((tool) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_outline_sharp,
                        size: 18,
                        color: colorScheme.primary.withOpacity(0.8),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tool,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }
}
