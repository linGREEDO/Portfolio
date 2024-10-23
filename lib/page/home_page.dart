import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/haku.dart';

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
  late Animation<double> _jumpAnimation;
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _jumpController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _jumpAnimation = Tween<double>(begin: 0, end: 50).animate(
      CurvedAnimation(
        parent: _jumpController,
        curve: Curves.easeInOut,
      ),
    );

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
      extendBodyBehindAppBar: true,
      appBar: _buildResponsiveAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeroSection(context),
                _buildAboutMeSection(context),
                _buildSkillsSection(context),
                _buildProjectsSection(context),
                _buildContactSection(context),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: widget.toggleTheme,
              child: AnimatedBuilder(
                animation: _jumpAnimation,
                builder: (context, child) {
                  final isDarkMode =
                      Theme.of(context).brightness == Brightness.dark;
                  return Transform.translate(
                    offset: Offset(0, -_jumpAnimation.value),
                    child: Image.asset(
                      isDarkMode
                          ? 'assets/images/l.png'
                          : 'assets/images/soot_sprite.png',
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return AppBar(
      scrolledUnderElevation: 1,
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
          'dyari',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
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
            Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 5)
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

  Widget _buildHeroSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 600;

    return Container(
      key: _heroKey,
      height: screenSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/background.gif'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.shadow.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                color: colorScheme.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Innovating with Code',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                        ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 300.ms)
                      .moveY(begin: 30, end: 0),
                  const SizedBox(height: 20),
                  Text(
                    'Dyari Ali Taher',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .moveY(begin: 30, end: 0),
                  const SizedBox(height: 10),
                  Text(
                    'Flutter Developer & Computer Science Enthusiast',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 900.ms)
                      .moveY(begin: 30, end: 0),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Add action to scroll to projects or open CV
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => _scrollToSection(_aboutMeKey),
                      child: const Text(
                        'Explore My Work',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 1200.ms)
                      .scale(begin: const Offset(0.8, 0.8)),
                ],
              ),
            ),
          ),
          if (isDesktop)
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

  Widget _buildAboutMeSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      key: _aboutMeKey,
      color: colorScheme.surface,
      padding: const EdgeInsets.all(40.0),
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
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
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
                      Image.asset("assets/images/mo.webp",
                              width: 200, height: 200)
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 600.ms)
                          .slideY(begin: 50, end: 0)
                          .animate()
                          .scale(delay: 300.ms, duration: 600.ms),
                      const SizedBox(height: 20),
                      Text(
                        'Dyari Ali Taher',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                      ),
                      Text(
                        '21 years old',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color:
                                  colorScheme.onSurfaceVariant.withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideY(begin: 50, end: 0),
              ),
              const SizedBox(width: 30),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                      Text(
                        "🚀 My Expertise:",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 10),
                      _buildExpertiseItem(
                          context, "Web Development", Icons.web),
                      _buildExpertiseItem(context, "Mobile App Development",
                          Icons.phone_android),
                      _buildExpertiseItem(context, "Windows App Development",
                          Icons.desktop_windows),
                      const SizedBox(height: 20),
                      Text(
                        "🌟 Skills & Knowledge:",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "I've delved into algorithms, web development principles, computer applications, Firebase, MySQL, assembly, and artificial intelligence. My broad understanding of IT keeps me curious and always learning!",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                              height: 1.5,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "🗣️ Languages:",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildLanguageChip(context, "Kurdish (Native)"),
                          const SizedBox(width: 10),
                          _buildLanguageChip(context, "English (Fluent)"),
                        ],
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideY(begin: 50, end: 0),
              ),
            ],
          ),
        ],
      ),
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
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
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

  Widget _buildSkillsSection(BuildContext context) {
    return Container(
      key: _skillsKey,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/c.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.5)
            ],
          ),
        ),
        child: Column(
          children: [
            Text('Programming Skills',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Theme.of(context).colorScheme.shadow,
                              blurRadius: 3)
                        ]))
                .animate()
                .fadeIn(duration: 600.ms)
                .slideX(begin: -30, end: 0),
            const SizedBox(height: 40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                _buildSkillCard(
                    context,
                    'Flutter',
                    'Full-Stack Development',
                    ['Dart', 'Firebase', 'Bloc', 'REST APIs'],
                    Icons.flutter_dash_outlined),
                _buildSkillCard(context, 'Java', 'Backend Development',
                    ['Spring Boot', 'MySQL'], Icons.code),
                _buildSkillCard(
                    context,
                    'C#',
                    'Desktop/Backend Development',
                    ['ASP.NET', 'Entity Framework', 'SQL Server'],
                    Icons.computer),
                _buildSkillCard(context, 'PHP', 'Backend Development',
                    ['MySQL'], Icons.computer),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, String skill, String category,
      List<String> tools, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: colorScheme.surfaceContainer,
      child: Container(
        width: isDesktop ? 300 : double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: colorScheme.primary),
            const SizedBox(height: 10),
            Text(skill,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondary)),
            Text(category,
                style: TextStyle(
                    fontSize: 16, color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            ...tools.map((tool) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 16, color: colorScheme.primary),
                      const SizedBox(width: 5),
                      Text(tool,
                          style: TextStyle(
                              fontSize: 14, color: colorScheme.onSurface)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildProjectsSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      key: _projectsKey,
      color: colorScheme.surface,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('Projects',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary))
                .animate()
                .fadeIn(duration: 600.ms)
                .slideX(begin: -30, end: 0),
          ),
          const SizedBox(height: 40),
          _buildProjectCard(
            context,
            'Personal Portfolio',
            'A Flutter web application showcasing my skills and projects.',
            ['Flutter', 'Dart', 'Web'],
            'https://github.com/linGREEDO/portfolio',
          ),
          const SizedBox(height: 20),
          _buildProjectCard(
            context,
            'Employee Manager App',
            'A desktop application for managing daily tasks and schedules.',
            ['Java', 'Local Storage', 'Bloc'],
            'https://github.com/linGREEDO',
          ),
          const SizedBox(height: 20),
          _buildProjectCard(
            context,
            'Restaurant Menu App',
            'A mobile application for checking menu of a restaurant and booking delivery via WhatsApp.',
            ['Flutter', 'Dart', 'Firebase', 'Bloc'],
            'https://github.com/linGREEDO',
          ),
          _buildProjectCard(
            context,
            'Library Management System',
            'A web application for managing books and users in a library.',
            ['PHP', 'MySQL', 'HTML', 'CSS', 'JavaScript'],
            'https://github.com/linGREEDO',
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, String title,
      String description, List<String> technologies, String githubLink) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      color: colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface)),
            const SizedBox(height: 10),
            Text(description,
                style: TextStyle(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 15),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: technologies
                  .map((tech) => Chip(
                        label: Text(tech),
                        backgroundColor: colorScheme.primaryContainer,
                        labelStyle:
                            TextStyle(color: colorScheme.onPrimaryContainer),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () => _launchURL(githubLink),
              icon: const Icon(Icons.code),
              label: const Text('View on GitHub'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiaryContainer,
                foregroundColor: colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 50, end: 0);
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      key: _contactKey,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/contact_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.5)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Contact Me',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          const Shadow(color: Colors.black, blurRadius: 3)
                        ],
                      ))
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: -30, end: 0),
            ),
            const SizedBox(height: 40),
            _buildContactCard(
                context,
                'Discord',
                'lingreed',
                'https://discordapp.com/users/579322519098621980',
                Icons.discord),
            _buildContactCard(context, 'Email', 'dyarialitaher03@gmail.com',
                'mailto:dyarialitaher03@gmail.com', Icons.email),
            _buildContactCard(context, 'GitHub', 'linGREEDO',
                'https://github.com/linGREEDO', Icons.code),
            _buildContactCard(
                context,
                'LinkedIn',
                'Dyari Ali Taher',
                'https://www.linkedin.com/in/dyari-ali-tahir-b005352b5/',
                Icons.link),
            _buildContactCard(context, "Whatsapp Number", "+(964) 750 895 9395",
                "", Icons.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, String platform,
      String username, String link, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.onSecondaryContainer,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.tertiaryContainer, size: 32),
        title: Text(platform,
            style: TextStyle(
                color: colorScheme.onSurface, fontWeight: FontWeight.bold)),
        subtitle: Text(username,
            style: TextStyle(color: colorScheme.onSurfaceVariant)),
        trailing: Icon(Icons.arrow_forward_ios, color: colorScheme.primary),
        onTap: () => _launchURL(link),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideX(begin: 50, end: 0);
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
