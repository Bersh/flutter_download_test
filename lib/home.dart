import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'download_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black, title: const Text("File Downloading")),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            downloadButton(fileDownloaderProvider),
            downloadProgress(),
            MaterialButton(
              onPressed: () {

              },
              textColor: Colors.black,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Test Button",
              ),
            )
          ]),
        ));
  }

  Widget downloadButton(FileDownloaderProvider downloaderProvider) {
    return MaterialButton(
      onPressed: () {
        downloaderProvider
            .downloadFile("http://212.183.159.230/200MB.zip", "200MB.zip")
            .then((onValue) {});
      },
      textColor: Colors.black,
      color: Colors.redAccent,
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        "Download File",
      ),
    );
  }

  Widget downloadProgress() {
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: true);

    return Text(
      downloadStatus(fileDownloaderProvider),
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  downloadStatus(FileDownloaderProvider fileDownloaderProvider) {
    var retStatus = "";

    switch (fileDownloaderProvider.downloadStatus) {
      case DownloadStatus.Downloading:
        {
          retStatus = "Download Progress : " +
              fileDownloaderProvider.downloadPercentage.toString() +
              "%";
        }
        break;
      case DownloadStatus.Completed:
        {
          retStatus = "Download Completed";
        }
        break;
      case DownloadStatus.NotStarted:
        {
          retStatus = "Click Download Button";
        }
        break;
      case DownloadStatus.Started:
        {
          retStatus = "Download Started";
        }
        break;
    }

    return retStatus;
  }
}
