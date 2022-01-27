import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/news_app/web_view/web_view_screen.dart';

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  bool isPssword = false,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isClickable = true,
  required  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,


}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPssword,
  onFieldSubmitted: onSubmit ,

  onChanged: onChange ,
  onTap: onTap,
  enabled: isClickable,
  validator: validate,
  decoration: InputDecoration(
    labelText: label ,
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      onPressed :suffixPressed,
      icon: Icon(
          suffix
      ),
    ),
  ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    height: 1.0,
    color: Colors.grey[300],
    width: double.infinity,
  ),
);

Widget buildArticleItem(article,context ) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children:

      [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children:

              [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder (list , context , {isSearch = false} ) => BuildCondition(
  condition: list.length > 0 ,
  builder:(context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context ,index) => buildArticleItem(list[index] , context),
    separatorBuilder: (context , index) => myDivider(),
    itemCount: 15,
  ),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()) ,
);

void navigateTo(context , widget) => Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);



