import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

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
  }

  @override
  void dispose() {
    _jumpController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          onTap: () => _scrollToSection(_heroKey),
          child: Text('LinGreed',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  )),
        ),
        actions: [
          _buildNavButton(context, 'About', _aboutMeKey),
          _buildNavButton(context, 'Skills', _skillsKey),
          _buildNavButton(context, 'Projects', _projectsKey),
          _buildNavButton(context, 'Contact', _contactKey),
        ],
      ),
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
                ]),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: widget.toggleTheme,
              child: AnimatedBuilder(
                animation: _jumpAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -_jumpAnimation.value),
                    child: Image.asset(
                      'assets/images/x.png',
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

  Widget _buildNavButton(BuildContext context, String title, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollToSection(key),
      child: Text(title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              )),
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
    return Container(
      key: _heroKey,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/hero_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorScheme.surface.withOpacity(0.5), colorScheme.surface],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to my portfolio!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
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
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .moveY(begin: 30, end: 0),
              const SizedBox(height: 10),
              Text(
                'Flutter Developer | Computer Science Student',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant,
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 900.ms)
                  .moveY(begin: 30, end: 0),
            ],
          ),
        ),
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
          Text('About Me',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: colorScheme.primary))
              .animate()
              .fadeIn(duration: 600.ms)
              .slideX(begin: -30, end: 0),
          const SizedBox(height: 20),
          Text(
            "I'm a 21-year-old student from Kurdistan, currently in my senior year studying Computer Science at Knowledge University. My main areas of focus are web development, mobile application development, and Windows application development. I'm proficient in office programs and various AI tools.\n\nMy studies have also covered algorithms, web development principles, computer applications, Firebase, MySQL, assembly, and artificial intelligence. I have a broad understanding of IT and continue to explore new aspects of the computer field.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 300.ms),
        ],
      ),
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
                          const Shadow(color: Colors.black, blurRadius: 3)
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
    return Card(
      elevation: 4,
      color: colorScheme.surface,
      child: Container(
        width: 300,
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
                    color: colorScheme.onSurface)),
            Text(category,
                style: TextStyle(
                    fontSize: 16, color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            ...tools.map((tool) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $tool',
                      style: TextStyle(
                          fontSize: 14, color: colorScheme.onSurface)),
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
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.onSecondary,
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
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, String platform,
      String username, String link, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.surface,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary, size: 32),
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
