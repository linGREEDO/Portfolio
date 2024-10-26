import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../service/launcher.dart';

class ProjectSection extends StatelessWidget {
  final GlobalKey scrollKey;
  const ProjectSection({super.key, required this.scrollKey});

  @override
  Widget build(BuildContext context) {
    return _buildProjectsSection(context);
  }

  Widget _buildProjectsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      key: scrollKey,
      color: colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Magical Projects',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -30, end: 0),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildProjectCard(
                    context,
                    'Personal Portfolio',
                    'A Flutter web application showcasing my skills and projects.',
                    ['Flutter', 'Dart', 'Web'],
                    'https://github.com/linGREEDO/portfolio',
                    'assets/images/x.png',
                    constraints,
                  ),
                  _buildProjectCard(
                    context,
                    'Employee Manager App',
                    'A desktop application for managing daily tasks and schedules.',
                    ['Java', 'Local Storage', 'Bloc'],
                    'https://github.com/linGREEDO',
                    'assets/images/l.png',
                    constraints,
                  ),
                  _buildProjectCard(
                    context,
                    'Restaurant Menu App',
                    'A mobile application for checking menu of a restaurant and booking delivery via WhatsApp.',
                    ['Flutter', 'Dart', 'Firebase', 'Bloc'],
                    'https://github.com/linGREEDO',
                    'assets/images/kodama.png',
                    constraints,
                  ),
                  _buildProjectCard(
                    context,
                    'Library Management System',
                    'A web application for managing books and users in a library.',
                    ['PHP', 'MySQL', 'HTML', 'CSS', 'JavaScript'],
                    'https://github.com/linGREEDO',
                    'assets/images/soot_sprite.png',
                    constraints,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String description,
    List<String> technologies,
    String githubLink,
    String imagePath,
    BoxConstraints constraints,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardWidth = constraints.maxWidth > 600 ? 280.0 : constraints.maxWidth;

    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: colorScheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  Image.asset(
                    imagePath,
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: technologies
                    .map((tech) => Chip(
                          label: Text(tech),
                          backgroundColor: colorScheme.secondaryContainer,
                          labelStyle: TextStyle(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => Launcher.launchURL(githubLink),
                icon: const Icon(Icons.code),
                label: const Text('View on GitHub'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.tertiaryContainer,
                  foregroundColor: colorScheme.onTertiaryContainer,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }
}
