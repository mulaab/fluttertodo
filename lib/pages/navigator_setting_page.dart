import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/nav_head.dart';

class NavSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final globalModel = Provider.of<GlobalModel>(context);

    final netUrl = "https://api.dujin.org/bing/1366.php";


    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).navigatorSetting),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RadioListTile(
              value: "MeteorShower",
              groupValue: globalModel.currentNavHeader,
              subtitle: NavHead(),
              onChanged: (value) async{
                await onChanged(globalModel, value);
              },
              title: Text(DemoLocalizations.of(context).meteorShower),
            ),
            RadioListTile(
              value: "NetPicture",
              groupValue: globalModel.currentNavHeader,
              subtitle: CachedNetworkImage(
                imageUrl: "https://api.dujin.org/bing/1366.php",
                placeholder: (context, url) => new Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
                ),
                errorWidget: (context, url, error) => new Icon(Icons.error,color: Colors.redAccent,),
              ),
              onChanged: (value) async{
                await onChanged(globalModel, value);
              },
              title: Text(DemoLocalizations.of(context).netPicture),
            ),
          ],
        ),
      ),
    );
  }

  Future onChanged(GlobalModel globalModel, value) async {
    if(globalModel.currentNavHeader != value){
      globalModel.currentNavHeader = value;
      globalModel.refresh();
      final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
      await SharedUtil.instance.saveString(Keys.currentNavHeader + account, value);
    }
  }
}