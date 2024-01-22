import 'package:carrot_flutter/src/connect/feed_connect.dart';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final feedConnect = Get.put(FeedConnect());

class FeedController extends GetxController {
  List<FeedModel> list = [];

  feedIndex({int page = 1}) async {
    List jsonData = await feedConnect.getList(page);
    if (page == 1) {
      list.clear();
    }
    List<FeedModel> tmp = jsonData.map((m) => FeedModel.parse(m)).toList();
    list.addAll(tmp);
    update();
  }

  Future<bool> feedCreate(
      String title, String content, String price, int? imageId) async {
    try {
      // 작성 완료 후 목록 새로고침
      await feedConnect.storeItem(title, price, content, imageId: imageId);
      await feedIndex();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text('$e'),
      ));
      return false;
    }
  }

  Future<int> upload(String name, String path) async {
    Map data = await feedConnect.imageUpload(name, path);
    return data['id'];
  }
}
