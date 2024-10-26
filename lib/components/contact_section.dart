import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../service/launcher.dart';

class ContactSection extends StatelessWidget {
  final GlobalKey scrollKey;

  const ContactSection({super.key, required this.scrollKey});

  @override
  Widget build(BuildContext context) {
    return _buildContactSection(context);
  }

  Widget _buildContactSection(BuildContext context) {
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
            colorScheme.shadow.withOpacity(0.3),
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
              'Contact Me',
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 800 : 600,
              ),
              child: Column(
                children: [
                  _buildContactCard(
                    context,
                    'Discord',
                    'lingreed',
                    'https://discordapp.com/users/579322519098621980',
                    Icons.discord,
                    Colors.blue,
                  ),
                  _buildContactCard(
                    context,
                    'Email',
                    'dyarialitaher03@gmail.com',
                    'mailto:dyarialitaher03@gmail.com',
                    Icons.email,
                    Colors.red,
                  ),
                  _buildContactCard(
                    context,
                    'GitHub',
                    'linGREEDO',
                    'https://github.com/linGREEDO',
                    Icons.code,
                    Colors.black,
                  ),
                  _buildContactCard(
                      context,
                      'LinkedIn',
                      'Dyari Ali Taher',
                      'https://www.linkedin.com/in/dyari-ali-tahir-b005352b5/',
                      Icons.link,
                      Colors.blue),
                  _buildContactCard(context, "WhatsApp", "+(964) 750 895 9395",
                      "https://wa.me/9647508959395", Icons.phone, Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String platform,
    String username,
    String link,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Card(
      elevation: 4,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      margin: EdgeInsets.only(bottom: isDesktop ? 20 : 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.1),
          width: 1,
        ),
      ),
      color: colorScheme.surface.withOpacity(0.9),
      child: InkWell(
        onTap: link.isNotEmpty ? () => Launcher.launchURL(link) : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 24 : 16,
            vertical: isDesktop ? 20 : 16,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: isDesktop ? 28 : 24,
                ),
              ),
              SizedBox(width: isDesktop ? 24 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      platform,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: isDesktop ? 18 : 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      username,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: isDesktop ? 16 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (link.isNotEmpty) ...[
                SizedBox(width: isDesktop ? 24 : 16),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.primary.withOpacity(0.8),
                  size: isDesktop ? 24 : 20,
                ),
              ],
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideX(begin: 50, end: 0);
  }
}
