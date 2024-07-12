import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/Widgets/BlogCard.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(

      stream: FirebaseFirestore.instance.collection('blogPosts').snapshots(),

      builder: (BuildContext context,AsyncSnapshot snapshot){

        if(!snapshot.hasData) {

          return const CircularProgressIndicator();

        } if(snapshot.connectionState==ConnectionState.active){

          QuerySnapshot querySnapshot=snapshot.data;
          List<QueryDocumentSnapshot> list=querySnapshot.docs;

          // final posts = snapshot.data!.docs;

          return  ListView.builder(
            itemCount:list.length, // Replace with the actual number of blog posts
            itemBuilder: (context, index) {

              QueryDocumentSnapshot document=list[index];

              // final post = posts[index];
              final title = document['title'];
              final content = document['content'];
              final author = document['author'];
              final date = document['date'];
              final img = document['img'];

              return BlogCard(title: title, description: content, imageUrl: img, author: author, publishingDate: date);
            },
          );


          //   ListView.builder(
          //     itemCount: posts.length,
          //     itemBuilder: (context , index){
          //       final post = posts[index];
          //       final title = post['title'];
          //       final content = post['content'];
          //       return ListTile(
          //         title: Text(title),
          //         subtitle: Text(content),
          //       );
          //     }
          // );
        }
        if(snapshot.hasError){
          //
        }
        return const Center(child: CircularProgressIndicator());
      },
    );

  }
}

// ignore: must_be_immutable
class BlogDetailsPage extends StatelessWidget {

  dynamic  blogIndex;
  dynamic title, content, author, date;

  BlogDetailsPage(this.blogIndex,this.title,this.content,this.author,this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Post $blogIndex'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Blog Post $blogIndex',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
             Text(
              content,
            ),
            const SizedBox(height: 16),
             Text(
              'Author: $author',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              'Published: $date',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
