import 'package:carrot_flutter/src/screen/feed/index.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:carrot_flutter/src/widget/image_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  var inputDecoration = const InputDecoration(border: OutlineInputBorder());
  var labelTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  int? fileId;

  final ImagePicker picker = ImagePicker();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String price = _priceController.text;
      final String content = _contentController.text;

      // 피드 작성 로직
      bool result =
          await feedController.feedCreate(title, content, price, fileId);

      if (result) {
        Get.back();
      }
    }
  }

  void uploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    int id = await feedController.upload(image.name, image.path);
    setState(() {
      fileId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 물건 팔기'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // 이미지 버튼
            Row(
              children: [
                ImageButton(
                  imageUrl: fileId == null
                      ? null
                      : "${Global.apiRoot}/api/file/$fileId",
                  onTap: uploadImage,
                ),
              ],
            ),
            // 제목
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('제목', style: labelTextStyle),
                TextFormField(
                  decoration: inputDecoration,
                  controller: _titleController,
                )
              ],
            ),
            // 가격
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('가격', style: labelTextStyle),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration,
                  controller: _priceController,
                )
              ],
            ),
            // 내용
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('내용', style: labelTextStyle),
                TextFormField(
                  maxLines: 5,
                  decoration: inputDecoration,
                  controller: _contentController,
                )
              ],
            ),
            // 작성 버튼
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF7E36),
              ),
              child: const Text(
                '작성 완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
