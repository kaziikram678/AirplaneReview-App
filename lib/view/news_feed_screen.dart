import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socialapp/view/share_experienc_screen.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  Map<int, bool> showReplyBox = {};
  Map<int, TextEditingController> replyControllers = {};
  Map<int, bool> showAllComments = {};

  List<Map<String, dynamic>> posts = [
    {
      'username': 'Md Ikram',
      'timeAgo': '1 day ago',
      'rating': 5,
      'departure': 'LHR',
      'arrival': 'DEL',
      'airline': 'Biman Bangladesh Airlines',
      'class': 'Business Class',
      'travelDate': 'July 2023',
      'message': 'Stay tuned for a smoother, more convenient experience...',
      'image': 'assets/images/room.jpg',
      'likes': 30,
      'isLiked': false,
      'comments': [
        {
          'text': 'Seems really nice',
          'upvotes': 5,
          'author': 'Omer Faruq',
          'time': '5 min ago',
          'replies': [],
        },
      ],
    },
  ];

  void addPost(Map<String, dynamic> newPost) {
    setState(() {
      posts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Airline Review', style: TextStyle(color: Colors.black)),
            Row(
              children: [
                Icon(Icons.notifications_none, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.menu, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final newPost = await Navigator.push<Map<String, dynamic>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShareExperiencePage(),
                    ),
                  );
                  if (newPost != null) addPost(newPost);
                },
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text(
                  'Share Your Experience',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff232323),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.question_answer, color: Colors.white),
                label: Text(
                  'Ask A Question',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff232323),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Color(0xff232323),
              filled: true,
            ),
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/images/airplane.jpg"),
          ),
          SizedBox(height: 16),
          ...posts.map((post) => buildPostCard(context, post)).toList(),
        ],
      ),
    );
  }

  Widget buildPostCard(BuildContext context, Map<String, dynamic> post) {
    final commentController = TextEditingController();
    final comments = List<Map<String, dynamic>>.from(post['comments'] ?? []);
    comments.sort((a, b) => b['upvotes'].compareTo(a['upvotes']));

    showAllComments[post.hashCode] ??= false;
    final bool expanded = showAllComments[post.hashCode]!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey[400]),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['username'] ?? 'Anonymous',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            post['timeAgo'] ?? 'Just now',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(
                            '${post['rating']}.0',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 6,
              children: [
                tag(post['departure'] + ' - ' + post['arrival']),
                tag(post['airline']),
                tag(post['class']),
                tag(post['travelDate']),
              ],
            ),
            SizedBox(height: 10),
            Text(post['message'], maxLines: 4, overflow: TextOverflow.ellipsis),
            SizedBox(height: 8),

            // Image Grid Support (custom 5-image layout)
            if (post['images'] != null && post['images'].isNotEmpty)
              post['images'].length == 1
                  ? Column(
                    children: [
                      SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.file(
                                File(post['images'][0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : post['images'].length == 3
                  ? Column(
                    children: [
                      SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.file(
                                File(post['images'][2]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.file(
                                File(post['images'][0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Image.file(
                                File(post['images'][1]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : post['images'].length == 5
                  ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image.file(
                              File(post['images'][0]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Image.file(
                              File(post['images'][1]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Image.file(
                              File(post['images'][2]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Image.file(
                              File(post['images'][3]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Image.file(
                              File(post['images'][4]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : post['images'].length > 5
                  ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image.file(
                              File(post['images'][0]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Image.file(
                              File(post['images'][1]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Image.file(
                              File(post['images'][2]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Image.file(
                              File(post['images'][3]),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: SizedBox(
                              height: 120,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    File(post['images'][4]),
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    color: Colors.black45,
                                    child: Center(
                                      child: Text(
                                        "+${post['images'].length - 5}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        post['images'].length > 5 ? 5 : post['images'].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          post['images'].length == 1
                              ? 1
                              : (post['images'].length <= 3 ? 2 : 2),
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(post['images'][index]),
                        fit: BoxFit.cover,
                      );
                    },
                  )
            else if (post['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    post['image'].toString().startsWith('assets/')
                        ? Image.asset(
                          post['image'],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                        : Image.file(
                          File(post['image']),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
              ),

            SizedBox(height: 10),
            Row(
              children: [
                Text('${post['likes']} Like'),
                SizedBox(width: 20),
                Text('${comments.length} Comment'),
              ],
            ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      post['isLiked'] = !(post['isLiked'] ?? false);
                      post['likes'] += post['isLiked'] ? 1 : -1;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        post['isLiked'] == true
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        color: post['isLiked'] == true ? Colors.blue : null,
                      ),
                      SizedBox(width: 10),
                      Text('Like'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.share_outlined),
                    SizedBox(width: 10),
                    Text('Share'),
                  ],
                ),
              ],
            ),
            Divider(height: 20),
            ...(comments.isEmpty
                    ? []
                    : (expanded ? comments : [comments.first]))
                .asMap()
                .entries
                .map((entry) {
                  int i = entry.key;
                  final comment = entry.value;

                  replyControllers[i] ??= TextEditingController();
                  showReplyBox[i] ??= false;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey[400],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['author'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '${comment['time']}',
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '${comment['upvotes']} Upvotes',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(comment['text'], style: TextStyle(fontSize: 13)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => comment['upvotes']++),
                            child: Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined, size: 16),
                                SizedBox(width: 4),
                                Text('Upvote', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () => setState(() => showReplyBox[i] = true),
                            child: Row(
                              children: [
                                Icon(Icons.reply, size: 16),
                                SizedBox(width: 4),
                                Text('Reply', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (showReplyBox[i] == true) ...[
                        SizedBox(height: 8),
                        TextField(
                          controller: replyControllers[i],
                          decoration: InputDecoration(
                            hintText: 'Write a reply',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                final replyText =
                                    replyControllers[i]!.text.trim();
                                if (replyText.isNotEmpty) {
                                  setState(() {
                                    comment['replies'] =
                                        comment['replies'] ?? [];
                                    comment['replies'].add({
                                      'text': replyText,
                                      'author': 'You',
                                      'time': 'Just now',
                                    });
                                    replyControllers[i]!.clear();
                                    showReplyBox[i] = false;
                                  });
                                }
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                      if (comment['replies'] != null)
                        ...comment['replies'].map<Widget>(
                          (reply) => Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 8.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.grey[400],
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${reply['author']} • ${reply['time']}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reply['text'],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                }),

            if (!expanded && comments.length > 1)
              TextButton(
                onPressed:
                    () => setState(() => showAllComments[post.hashCode] = true),
                child: Text(
                  'See More Comments',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            SizedBox(height: 10),

            Row(
              children: [
                CircleAvatar(radius: 14, backgroundColor: Colors.grey[400]),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Write Your Comment',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          final commentText = commentController.text.trim();
                          if (commentText.isNotEmpty) {
                            setState(() {
                              post['comments'].insert(0, {
                                'text': commentText,
                                'author': 'You',
                                'time': 'Just now',
                                'upvotes': 0,
                                'replies': [],
                              });
                              commentController.clear();
                            });
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(fontSize: 12)),
    );
  }

}
