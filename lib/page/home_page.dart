import 'package:flutter/material.dart';
import 'package:lin_portfolio/components/about_me.dart';
import 'package:lin_portfolio/components/contact_section.dart';
import 'package:lin_portfolio/components/hero_section.dart';
import 'package:lin_portfolio/components/skill_section.dart';

import '../components/project_section.dart';

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const MyHomePage({super.key, required this.toggleTheme});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutMeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late AnimationController _jumpController;
  late AnimationController _floatingController;
  @override
  void initState() {
    super.initState();
    _jumpController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _jumpController.dispose();
    _scrollController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: _buildResponsiveAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroSection(
                  scrollKey: _heroKey,
                  aboutMeKey: _aboutMeKey,
                ),
                AboutMeSection(scrollKey: _aboutMeKey),
                SkillSection(scrollKey: _skillsKey),
                ProjectSection(scrollKey: _projectsKey),
                ContactSection(scrollKey: _contactKey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return AppBar(
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      elevation: 0,
      title: GestureDetector(
        onTap: () => _scrollToSection(_heroKey),
        child: Text(
          'Ling Greed',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                  blurRadius: 5)
            ],
          ),
        ),
      ),
      actions: isDesktop
          ? [
              _buildNavButton(context, 'About', _aboutMeKey),
              _buildNavButton(context, 'Skills', _skillsKey),
              _buildNavButton(context, 'Projects', _projectsKey),
              _buildNavButton(context, 'Contact', _contactKey),
            ]
          : [
              IconButton(
                onPressed: widget.toggleTheme,
                icon: GestureDetector(
                  onTap: widget.toggleTheme,
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/giphy (2).webp'
                        : 'assets/images/soot_sprite.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.menu,
                    color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => _showMobileMenu(context),
              ),
            ],
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(_aboutMeKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Skills'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(_skillsKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Projects'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(_projectsKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(_contactKey);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavButton(BuildContext context, String title, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollToSection(key),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                blurRadius: 5)
          ],
        ),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
