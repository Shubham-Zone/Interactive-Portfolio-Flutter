import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/Helpers/ThemeProvider.dart';
import 'package:portfolio/Screens/Blogs.dart';
import 'package:portfolio/Widgets/card.dart';
import 'package:portfolio/Widgets/DynamicButton.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'Contact.dart';
import 'Portfolio.dart';
import 'SocialMedia.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/Widgets/EducationCard.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  final int initialIndex;

  const Home({Key? key, required this.initialIndex}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pages = [
    const HomePage(),
    const PortfolioWidget(),
    const BlogWidget(),
    const SocialMediaHandlesWidget(),
    ContactWidget()
  ];

  late int idx;

  // Method to update the active index
  void updateIndex(int newIndex) {
    setState(() {
      idx = newIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    idx = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Orientation orientation = MediaQuery.of(context).orientation;

    // Function to build a navigation item for the drawer
    Widget buildDrawerNavItem(BuildContext context, String title, int index) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        hoverColor: Colors.grey[800],
        onTap: () {
          setState(() {
            idx = index;
          });
          Navigator.pop(context);
        },
      );
    }

    // Method to build each navbar item
    Widget buildNavBarItem(String title, int index) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            updateIndex(index);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: idx == index ? 45 : 0, // Adjust width based on idx
                color: idx == index
                    ? Colors.blue
                    : Colors.transparent, // Adjust color based on idx
                margin: const EdgeInsets.only(top: 4),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: (orientation == Orientation.landscape)
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shubham Kumar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                if (themeProvider.isDarkMode) {
                                  themeProvider.toggleTheme(false);
                                } else {
                                  themeProvider.toggleTheme(true);
                                }
                              },
                              child: Icon(
                                themeProvider.isDarkMode
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                size: 35,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          buildNavBarItem('Home', 0),
                          const SizedBox(
                            width: 20,
                          ),
                          buildNavBarItem('Projects', 1),
                          const SizedBox(
                            width: 20,
                          ),
                          buildNavBarItem('Blog', 2),
                          const SizedBox(
                            width: 20,
                          ),
                          buildNavBarItem('Social Media', 3),
                          const SizedBox(
                            width: 20,
                          ),
                          buildNavBarItem('Contact', 4),
                        ],
                      ),
                    ],
                  ),
                )
              : AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState
                          ?.openDrawer(); // Open drawer on tap
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bck2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color:
                    Colors.black.withOpacity(0.4), // Semi-transparent overlay
              ),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: pages[idx],
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),
          drawer: (orientation == Orientation.landscape)
              ? null
              : Drawer(
                  backgroundColor: Colors.white,
                  child: Container(
                    color: themeProvider.isDarkMode
                        ? Colors.grey[900]
                        : Colors.white,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        // Drawer Header
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkMode
                                ? Colors.black
                                : Colors.blue,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/header_bg.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/profile.jpg',),
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Shubham Kumar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Flutter Developer',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Close button
                        ListTile(
                          leading: Icon(
                            Icons.close,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.grey,
                          ),
                          title: Text(
                            'Close',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Divider(
                            color: themeProvider.isDarkMode
                                ? Colors.white54
                                : Colors.black54),
                        // Dark mode toggle
                        ListTile(
                          leading: Icon(
                            themeProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.grey,
                          ),
                          title: Text(
                            themeProvider.isDarkMode
                                ? 'Dark Mode'
                                : 'Light Mode',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            themeProvider
                                .toggleTheme(!themeProvider.isDarkMode);
                          },
                        ),
                        Divider(
                            color: themeProvider.isDarkMode
                                ? Colors.white54
                                : Colors.black54),
                        // Navigation items
                        buildDrawerNavItem(context, 'Home', 0),
                        buildDrawerNavItem(context, 'Projects', 1),
                        buildDrawerNavItem(context, 'Blog', 2),
                        buildDrawerNavItem(context, 'Social Media', 3),
                        buildDrawerNavItem(context, 'Contact', 4),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHovering = false;

  Timer? timer;

  final controller = FlipCardController();

  void startFlipping() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      controller.flipcard();
    });
  }


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    Orientation orientation = MediaQuery.of(context).orientation;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width > 800 ? 500 : 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I AM A DEVELOPER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (orientation == Orientation.portrait)
                          ? mq.height * 0.04
                          : mq.height * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: (orientation == Orientation.portrait)
                            ? mq.height * 0.06
                            : mq.height * 0.08,
                        child: DynamicButton(
                          label: "View Work",
                          iconData: Icons.computer,
                          nav: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home(
                                          initialIndex: 1,
                                        )));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: (orientation == Orientation.portrait)
                            ? mq.height * 0.06
                            : mq.height * 0.08,
                        child: DynamicButton(
                          label: "Hire me",
                          iconData: Icons.work,
                          nav: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home(
                                          initialIndex: 4,
                                        )));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          // About mySelf
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: (orientation == Orientation.landscape)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Lottie.asset("assets/lottie/animation1.json",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'About ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 28,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Myself',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "I am a skilled full stack developer with expertise in both frontend and backend development. I have a strong foundation in Flutter for building dynamic and responsive user interfaces. On the backend, I am proficient in various technologies such as Node.js, Express, and databases like MongoDB. I thrive in designing and implementing scalable architecture, creating efficient APIs, and ensuring smooth data flow between the frontend and backend components. With a passion for problem-solving and staying up-to-date with the latest industry trends, I am dedicated to delivering high-quality and user-centric applications. I am an effective collaborator and possess excellent communication skills, allowing me to work seamlessly in both individual and team-oriented environments. My goal is to leverage my skills and experience to create innovative and robust solutions that meet the needs of clients and users.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: mq.width * 0.7,
                        child: Image.asset("assets/images/lottie2.json",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: mq.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'About ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 28,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Myself',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "I am a skilled full stack developer with expertise in both frontend and backend development. I have a strong foundation in Flutter for building dynamic and responsive user interfaces. On the backend, I am proficient in various technologies such as Node.js, Express, and databases like MongoDB. I thrive in designing and implementing scalable architecture, creating efficient APIs, and ensuring smooth data flow between the frontend and backend components. With a passion for problem-solving and staying up-to-date with the latest industry trends, I am dedicated to delivering high-quality and user-centric applications. I am an effective collaborator and possess excellent communication skills, allowing me to work seamlessly in both individual and team-oriented environments. My goal is to leverage my skills and experience to create innovative and robust solutions that meet the needs of clients and users.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.all(45),
            child: SizedBox(
              child: Align(
                  alignment: Alignment.center,
                  child: Text("Education",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start)),
            ),
          ),
          const SizedBox(height: 10),

          // Education
          const EducationCard(
              imageUrl: "assets/images/ymca.png",
              institution:
                  "J.C Bose University of Science and Technology, Ymca Faridabad",
              degree: "MCA",
              duration: "2023-2025"),
          const EducationCard(
              imageUrl: "assets/images/du.jpg",
              institution: "Aryabhatta college (University of Delhi)",
              degree: "B.Sc.(Hons) Computer Science",
              duration: "2020-2023"),
          const EducationCard(
              imageUrl: "assets/images/mnm.jpg",
              institution: "M.N.M Public School Jundla (Karnal)",
              degree: "7th-12th",
              duration: "2015-2020"),
          const SizedBox(height: 18),

          // Cards
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              height: 210,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    SkillsCard(
                        title: "Skills",
                        skills:
                            'Flutter, Dart, Firebase, MongoDB, Nodejs, ExpressJs, Restful API'),
                    SizedBox(width: 10),
                    SkillsCard(
                        title: "Projects",
                        skills: 'Citizens Squad, PCOS Detection, Campus Cafe'),
                    SizedBox(width: 10),
                    SkillsCard(
                        title: "Testimonials",
                        skills: 'Great work, Excellent service'),
                    SizedBox(width: 10),
                    SkillsCard(
                        title: "Contact",
                        skills:
                            'Email: devshubham652@gmail.com, Phone: +919050074225'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),

          // Skills and expertise
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: (orientation == Orientation.landscape)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Lottie.asset("assets/lottie/animation4.json",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Skills and Expertise",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "• Programming Languages: Java, Dart, JavaScript, Python, C++.\n\n"
                              "• Frameworks: Flutter, React, Node.js, Express.js.\n\n"
                              "• Databases: MongoDB, Firebase, SQL.\n\n"
                              "• Tools: Git, VS Code, Android Studio, Docker.\n\n"
                              "• Web Technologies: HTML, CSS, Tailwind CSS.\n\n",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image.asset("assets/images/lottie1.json",
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Skills and Expertise",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "• Programming Languages: Java, Dart, JavaScript, Python, C++.\n\n"
                              "• Frameworks: Flutter, React, Node.js, Express.js.\n\n"
                              "• Databases: MongoDB, Firebase, SQL.\n\n"
                              "• Tools: Git, VS Code, Android Studio, Docker.\n\n"
                              "• Web Technologies: HTML, CSS, Tailwind CSS.\n\n",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),

          // // Tech Stack
          // Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: (orientation == Orientation.landscape)
          //         ? Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 width: MediaQuery.of(context).size.width * 0.4,
          //                 child: Lottie.asset("assets/lottie/animation3.json",
          //                     fit: BoxFit.cover),
          //               ),
          //               SizedBox(
          //                 width: MediaQuery.of(context).size.width * 0.4,
          //                 child: const Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Tech Stack',
          //                       style: TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         color: Colors.blue,
          //                         fontSize: 28,
          //                       ),
          //                     ),
          //                     SizedBox(height: 10),
          //                     Text(
          //                       "• Android Development: Java\n"
          //                       "• Cross-platform Development: Flutter\n"
          //                       "• Web Development: MERN Stack (MongoDB, Express.js, React.js, Node.js)\n"
          //                       "• Firebase\n"
          //                       "• MongoDB\n"
          //                       "• Node.js\n"
          //                       "• Tailwind CSS\n"
          //                       "• HTML\n"
          //                       "• CSS\n"
          //                       "• JavaScript\n"
          //                       "• TensorFlow\n"
          //                       "• Basic Languages: C++, Python, Java, C\n"
          //                       "• Machine Learning, AI\n"
          //                       "• APIs, HTTP, etc.",
          //                       style: TextStyle(
          //                         fontSize: 18,
          //                         color: Colors.white,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           )
          //         : Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 width: MediaQuery.of(context).size.width * 0.7,
          //                 child: Lottie.asset("assets/lottie/animation3.json",
          //                     fit: BoxFit.cover),
          //               ),
          //               SizedBox(
          //                 width: MediaQuery.of(context).size.width * 0.8,
          //                 child: const Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Tech Stack',
          //                       style: TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         color: Colors.blue,
          //                         fontSize: 28,
          //                       ),
          //                     ),
          //                     SizedBox(height: 10),
          //                     Text(
          //                       "• Android Development: Java\n"
          //                       "• Cross-platform Development: Flutter\n"
          //                       "• Web Development: MERN Stack (MongoDB, Express.js, React.js, Node.js)\n"
          //                       "• Firebase\n"
          //                       "• MongoDB\n"
          //                       "• Node.js\n"
          //                       "• Tailwind CSS\n"
          //                       "• HTML\n"
          //                       "• CSS\n"
          //                       "• JavaScript\n"
          //                       "• TensorFlow\n"
          //                       "• Basic Languages: C++, Python, Java, C\n"
          //                       "• Machine Learning, AI\n"
          //                       "• APIs, HTTP, etc.",
          //                       style: TextStyle(
          //                         fontSize: 16,
          //                         color: Colors.white,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           )),

          const SizedBox(height: 20),

          // Achievements
          GestureDetector(
            onTap: () {
              // Start or stop the flip animation on tap
              setState(() {
                if (isHovering) {
                  timer
                      ?.cancel(); // Stop the animation if the cursor is on the card
                } else {
                  startFlipping(); // Start the animation if the cursor is not on the card
                }
              });
            },
            onTapDown: (_) {
              setState(() {
                isHovering = true; // Cursor is on the card
                timer?.cancel(); // Stop the animation
              });
            },
            onTapUp: (_) {
              setState(() {
                isHovering = false; // Cursor is not on the card
                startFlipping(); // Start the animation
              });
            },
            child: (orientation == Orientation.landscape)
                ? FlipCard(
                    rotateSide: RotateSide.right,
                    onTapFlipping: true,
                    axis: FlipAxis.horizontal,
                    controller: controller,
                    frontWidget: Center(
                        child: Container(
                      width: mq.width * 0.9,
                      height: mq.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Icon(Icons.emoji_events,
                                    color: Colors.white, size: 120),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: const Text(
                                    "• Technical Team Head at GDSC, YMCA.\n\n"
                                    "• Two-time college topper in Data Structures and Algorithm at Coding Ninjas.\n\n"
                                    "• 1st position in CodeRush DSA Competition at Coding Ninjas.\n\n"
                                    "• 5th in CODEX-24 National Level Hackathon.\n\n"
                                    "• Contributor to GirlScriptOfCode and SocialSummerOfCode projects.\n\n",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    backWidget: Container(
                      width: mq.width * 0.9,
                      height: mq.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Achievements',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : FlipCard(
                    rotateSide: RotateSide.right,
                    onTapFlipping: true,
                    axis: FlipAxis.horizontal,
                    controller: controller,
                    frontWidget: Center(
                        child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: const Icon(Icons.emoji_events,
                                    color: Colors.white, size: 120),
                              ),
                              const SizedBox(height:10),
                               SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: const Text(
                                    "• Technical Team Head at GDSC, YMCA.\n\n"
                                    "• Two-time college topper in DSA at Coding Ninjas.\n\n"
                                    "• 1st position in CodeRush DSA Competition at Coding Ninjas.\n\n"
                                    "• 5th in CODEX-24 National Level Hackathon.\n\n"
                                    "• GSSOC'24 and SSOC'24 contributor.\n\n",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    backWidget: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Achievements',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),

          const SizedBox(height: 20),

          const SizedBox(height: 20),

          // Open source
          GestureDetector(
            onTap: () {
              // Start or stop the flip animation on tap
              setState(() {
                if (isHovering) {
                  timer
                      ?.cancel(); // Stop the animation if the cursor is on the card
                } else {
                  startFlipping(); // Start the animation if the cursor is not on the card
                }
              });
            },
            onTapDown: (_) {
              setState(() {
                isHovering = true; // Cursor is on the card
                timer?.cancel(); // Stop the animation
              });
            },
            onTapUp: (_) {
              setState(() {
                isHovering = false; // Cursor is not on the card
                startFlipping(); // Start the animation
              });
            },
            child: (orientation == Orientation.landscape)
                ? FlipCard(
                    rotateSide: RotateSide.left,
                    onTapFlipping: true,
                    axis: FlipAxis.horizontal,
                    controller: controller,
                    frontWidget: Center(
                        child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Icon(Icons.code,
                                    color: Colors.white, size: 120),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open Source Contributions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                      child: Text(
                                        "As a contributor to open-source projects, I have participated in Girlscript Summer of Code '24 and Social Summer of Code '24 powered by Microsoft. These programs provided me with valuable opportunities to collaborate with other developers, contribute to meaningful projects, and make a positive impact on the community. Through my contributions, I have gained valuable experience in software development best practices, teamwork, and problem-solving.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    backWidget: Container(
                      width: mq.width * 0.9,
                      height: mq.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Open Source Contributions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : FlipCard(
                    rotateSide: RotateSide.left,
                    onTapFlipping: true,
                    axis: FlipAxis.horizontal,
                    controller: controller,
                    frontWidget: Center(
                        child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: const Icon(Icons.code,
                                    color: Colors.white, size: 120),
                              ),
                              const SizedBox(
                                // width: MediaQuery.of(context).size.width * 0.4,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open Source Contributions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                      child: Text(
                                        "As a contributor to open-source projects, I have participated in Girlscript Summer of Code '24 and Social Summer of Code '24 powered by Microsoft. These programs provided me with valuable opportunities to collaborate with other developers, contribute to meaningful projects, and make a positive impact on the community. Through my contributions, I have gained valuable experience in software development best practices, teamwork, and problem-solving.",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    backWidget: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Open Source Contributions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
