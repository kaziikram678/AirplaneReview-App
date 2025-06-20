import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShareExperiencePage extends StatefulWidget {
  @override
  _ShareExperiencePageState createState() => _ShareExperiencePageState();
}

class _ShareExperiencePageState extends State<ShareExperiencePage> {
  final _formKey = GlobalKey<FormState>();
  String? departure, arrival, airline, travelClass, message;
  DateTime? travelDate;
  double rating = 4.0;
  List<File> selectedImages = [];

  final List<String> dummyAirports = ['DAC', 'CXB', 'CGP', 'JSR', 'SYD', 'KTM'];
  final List<String> dummyAirlines = ['Biman Bangladesh Airlines', 'US-Bangla Airlines', 'Regent Airways'];
  final List<String> travelClasses = [
    'Any',
    'Business',
    'First',
    'Premium Economy',
    'Economy',
  ];

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked != null) {
      setState(() {
        selectedImages = picked.map((x) => File(x.path)).toList();
      });
    }
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => travelDate = picked);
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newPost = {
        'username': 'You',
        'timeAgo': 'Just now',
        'rating': rating,
        'departure': departure ?? '',
        'arrival': arrival ?? '',
        'airline': airline ?? '',
        'class': travelClass ?? '',
        'travelDate':
            travelDate != null ? "${travelDate!.toLocal()}".split(' ')[0] : '',
        'message': message ?? '',
        'images': selectedImages.map((f) => f.path).toList(),
        'likes': 0,
        'isLiked': false,
        'comments': [],
      };

      Navigator.pop(context, newPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232323).withOpacity(0.8),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Share",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: pickImages,
                    child: DottedBorderBox(
                      child:
                          selectedImages.isEmpty
                              ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_rounded,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Drop Your Image Here Or ',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    'Browse',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              )
                              : buildImagePreview(),
                    ),
                  ),

                  SizedBox(height: 20),
                  buildDropdown(
                    "Departure Airport",
                    dummyAirports,
                    (val) => departure = val,
                  ),
                  SizedBox(height: 10),
                  buildDropdown(
                    "Arrival Airport",
                    dummyAirports,
                    (val) => arrival = val,
                  ),
                  SizedBox(height: 10),
                  buildDropdown(
                    "Airline",
                    dummyAirlines,
                    (val) => airline = val,
                  ),
                  SizedBox(height: 10),
                  buildDropdown(
                    "Class",
                    travelClasses,
                    (val) => travelClass = val,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write your message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (val) => message = val,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: pickDate,
                          icon: Icon(Icons.calendar_today, size: 18),
                          label: Text(
                            travelDate == null
                                ? "Travel Date"
                                : "${travelDate!.toLocal()}".split(' ')[0],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Rating"),
                      SizedBox(width: 8),
                      RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        itemSize: 24,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder:
                            (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (r) => setState(() => rating = r),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
    String hint,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      validator: (val) => val == null ? 'Please select $hint' : null,
    );
  }

  Widget buildImagePreview() {
    int count = selectedImages.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count > 5 ? 5 : count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count == 1 ? 1 : (count <= 3 ? 2 : 3),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        if (index == 4 && count > 5) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.file(selectedImages[index], fit: BoxFit.cover),
              Container(
                color: Colors.black45,
                child: Center(
                  child: Text(
                    "+${count - 4}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        }
        return Image.file(selectedImages[index], fit: BoxFit.cover);
      },
    );
  }
}

class DottedBorderBox extends StatelessWidget {
  final Widget child;
  const DottedBorderBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100,
      ),
      child: Center(child: child),
    );
  }
}
