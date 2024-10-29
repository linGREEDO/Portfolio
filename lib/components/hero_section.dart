import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simple_icons/simple_icons.dart';
import 'haku.dart';
import '../service/launcher.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey scrollKey;
  final GlobalKey aboutMeKey;

  const HeroSection({
    super.key,
    required this.scrollKey,
    required this.aboutMeKey,
  });

  @override
  Widget build(BuildContext context) {
    return _buildHeroSection(context);
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 900;
    final isTablet = screenSize.width >= 600 && screenSize.width < 900;

    return Container(
      key: scrollKey,
      height: screenSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/c.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            colorScheme.shadow.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.surface.withOpacity(0.1),
                  colorScheme.surface.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : 20,
                vertical: isDesktop ? 0 : 20,
              ),
              child: Card(
                elevation: 8,
                shadowColor: colorScheme.shadow.withOpacity(0.2),
                color: colorScheme.surfaceContainer.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop
                        ? 800
                        : isTablet
                            ? 600
                            : screenSize.width,
                  ),
                  padding: EdgeInsets.all(
                    isDesktop
                        ? 60
                        : isTablet
                            ? 40
                            : 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Innovating with Code',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 3,
                          fontSize: isDesktop
                              ? null
                              : isTablet
                                  ? 20
                                  : 18,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 300.ms)
                          .moveY(begin: 30, end: 0),
                      SizedBox(height: isDesktop ? 24 : 16),
                      Text(
                        'Dyari Ali Taher',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          height: 1.1,
                          fontSize: isDesktop
                              ? null
                              : isTablet
                                  ? 48
                                  : 36,
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 600.ms)
                          .moveY(begin: 30, end: 0),
                      SizedBox(height: isDesktop ? 16 : 12),
                      Text(
                        'Fullstack Flutter Developer',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: isDesktop
                              ? null
                              : isTablet
                                  ? 20
                                  : 18,
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 900.ms)
                          .moveY(begin: 30, end: 0),
                      SizedBox(height: isDesktop ? 40 : 32),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth >= 500) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildExploreButton(context, isDesktop),
                                const SizedBox(width: 16),
                                _buildCVButton(context, isDesktop),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                _buildExploreButton(context, isDesktop),
                                const SizedBox(height: 16),
                                _buildCVButton(context, isDesktop),
                              ],
                            );
                          }
                        },
                      ),
                      SizedBox(height: isDesktop ? 40 : 32),
                      _buildSocialLinks(context, isDesktop),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isDesktop || isTablet)
            const Positioned(
              top: 50,
              right: 0,
              left: 0,
              child: HakuAnimation(),
            ),
        ],
      ),
    );
  }

  Widget _buildExploreButton(BuildContext context, bool isDesktop) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilledButton.icon(
      onPressed: () => _scrollToSection(aboutMeKey),
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 32 : 24,
          vertical: isDesktop ? 16 : 12,
        ),
      ),
      icon: const Icon(Icons.explore),
      label: Text(
        'Explore My Work',
        style: TextStyle(
          fontSize: isDesktop ? 16 : 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 1200.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildCVButton(BuildContext context, bool isDesktop) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: () {
        // Add action to download CV or open in new tab
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 32 : 24,
          vertical: isDesktop ? 16 : 12,
        ),
      ),
      icon: const Icon(Icons.download),
      label: Text(
        'Download CV',
        style: TextStyle(
          fontSize: isDesktop ? 16 : 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 1400.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildSocialLinks(BuildContext context, bool isDesktop) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final socialLinks = [
      {
        'icon': Icons.discord,
        'url': 'https://discordapp.com/users/579322519098621980',
        'tooltip': 'Discord',
        Color: const Color(0xFF7289DA),
      },
      {
        'icon': Icons.email,
        'url': 'mailto:dyarialitaher03@gmail.com',
        'tooltip': 'Email',
        Color: const Color.fromARGB(255, 199, 22, 16),
      },
      {
        'icon': SimpleIcons.github,
        'url': 'https://github.com/linGREEDO',
        'tooltip': 'GitHub',
        Color: Theme.of(context).colorScheme.onSurface,
      },
      {
        'icon': SimpleIcons.linkedin,
        'url': 'https://www.linkedin.com/in/dyari-ali-tahir-b005352b5/',
        'tooltip': 'LinkedIn',
        Color: const Color(0xFF0a66c2),
      },
      {
        'icon': Icons.phone,
        'url': 'https://wa.me/9647508959395',
        'tooltip': 'WhatsApp',
        Color: const Color(0xFF25d366),
      },
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isDesktop ? 16 : 12,
      runSpacing: isDesktop ? 16 : 12,
      children: socialLinks.map((link) {
        return Tooltip(
          message: link['tooltip'] as String,
          child: InkWell(
            onTap: () => Launcher.launchURL(link['url'] as String),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(isDesktop ? 12 : 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outlineVariant.withOpacity(0.2),
                ),
              ),
              child: Icon(
                link['icon'] as IconData,
                color: link[Color] as Color,
                size: isDesktop ? 24 : 20,
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 1600.ms)
            .scale(begin: const Offset(0.8, 0.8));
      }).toList(),
    );
  }
}
