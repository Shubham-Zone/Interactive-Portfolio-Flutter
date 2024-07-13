import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('portfolio').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> list = querySnapshot.docs;

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot document = list[index];

                final title = document['title'];
                final detail = document['Detail'];
                final duration = document['Duration'];
                final technologies = document['Technologies'];
                final img = document["img"];
                final git = document["github"];
                // List urls = ["https://github.com/Shubham-Zone/Portfolio-website", "https://github.com/Shubham-Zone/Hackingly_project", "https://github.com/Shubham-Zone/CampusCaf-Flutter"];
  

                return ProjectDetailsPage(
                    title, detail, img, technologies, duration, git);
              });
        }
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(snapshot.error.toString())));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PortfolioItem extends StatefulWidget {
  final String title;
  final String description;
  final List<dynamic> imageUrl;
  final String technologies;
  final String duration;
  final VoidCallback onTap;

  const PortfolioItem(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.technologies,
      required this.duration,
      required this.onTap});

  @override
  _PortfolioItemState createState() => _PortfolioItemState();
}

class _PortfolioItemState extends State<PortfolioItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = isHovered ? 1.02 : 1.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        double imageHeight;

        if (screenWidth >= 1200) {
          imageHeight = 290;
        } else if (screenWidth >= 800) {
          imageHeight = 250;
        } else {
          imageHeight = 140;
        }

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: IntrinsicHeight(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()..scale(scaleFactor),
                decoration: BoxDecoration(
                  color:
                      isHovered ? Colors.blue.withOpacity(0.05) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    if (isHovered)
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      child: ImageNetwork(
                        image: widget.imageUrl.isNotEmpty
                            ? widget.imageUrl[0]
                            : '',
                        fitWeb: BoxFitWeb.cover,
                        height: imageHeight,
                        width: constraints.maxWidth,
                        duration: 1500,
                        curve: Curves.easeIn,
                        onPointer: true,
                        debugPrint: false,
                        fullScreen: false,
                        fitAndroidIos: BoxFit.cover,
                        onLoading: const CircularProgressIndicator(
                          color: Colors.indigoAccent,
                        ),
                        onError: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProjectDetailsPage extends StatelessWidget {

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  final String title;
  final String description;
  final List<dynamic> imageUrl;
  final String technologies;
  final String duration;
  final String git;

  const ProjectDetailsPage(
    this.title,
    this.description,
    this.imageUrl,
    this.technologies,
    this.duration,
    this.git, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
              const SizedBox(width: 1,),
              IconButton(onPressed: (){
                _launchURL(git);
              }, icon: const Icon(Icons.arrow_outward_outlined, color: Colors.blue,))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (int i = 0; i < imageUrl.length; i++)
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 2,
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return ImageNetwork(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar:
                                          AppBar(backgroundColor: Colors.transparent,), // Optional: Add an AppBar for better navigation experience
                                      body: Center(
                                        child: ImageNetwork(
                                          image:imageUrl[i],
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                        )
                                      ),
                                    ),
                                  ),
                                );
                              },
                              image: imageUrl[i],
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Adjusted width to fit the screen
                              height: constraints.maxWidth *
                                  0.5, // Set height based on width constraints for a flexible aspect ratio
                              fitWeb: BoxFitWeb.contain,
                              duration: 1500,
                              curve: Curves.easeIn,
                              onPointer: true,
                              debugPrint: false,
                              fullScreen: true,
                              fitAndroidIos: BoxFit.cover,
                              onLoading: const CircularProgressIndicator(
                                color: Colors.indigoAccent,
                              ),
                              onError: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      )),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text(
            'Technologies used:',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            technologies,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Text(
            'Duration: $duration',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
