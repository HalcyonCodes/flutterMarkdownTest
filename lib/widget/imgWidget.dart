import 'package:flutter/material.dart';

class ImgWidget extends StatelessWidget {
  String? url;
  String? clickUrl;
  BuildContext? imgContext;
  ImgWidget({
    required this.url,
    this.clickUrl,
  });

  @override
  Widget build(BuildContext context) {
    imgContext = context;
    return Container(
      child: Column(
        children: [
          if (clickUrl != null)
            InkWell(
              onTap: () {
                print("打开图片url链接");
                //打开链接代码
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Image.network(
                  url!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (clickUrl == null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Image.network(
                url!,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
