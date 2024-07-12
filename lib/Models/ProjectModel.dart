class project {

  final List<String> image;
  final String title, desc, technologies, duration;

  project({
    required this.image,
    required this.title,
    required this.technologies,
    required this.desc,
    required this.duration
  });

  factory project.fromJson(Map<String, dynamic> json) {
    return project(
      image: List<String>.from(json["image"]),
      title: json["title"],
      technologies: json["technologies"],
      desc: json["desc"],
      duration: json["duration"]
    );
  }
}
