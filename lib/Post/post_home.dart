
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'model/models.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'custom_header.dart';
import 'details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


/*
List<DataModel> dataList = [
  DataModel("Short Dress", "https://i.imgur.com/SngRPqe.jpg", 300.8),
  DataModel("Office Formals", "https://i.imgur.com/SngRPqe.jpg", 245.2),
  DataModel("Jeans Skirt", "https://i.imgur.com/SngRPqe.jpg", 136.7),
  DataModel("Casual Jeans", "https://i.imgur.com/SngRPqe.jpg", 168.2),
];*/



class PostHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}



class _CarouselWithIndicatorState extends State<PostHomeScreen>with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive=>true;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<DataModel> dataList = [
  DataModel("Loading...",
             "https://i.imgur.com/SngRPqe.jpg",
            "Loading content..."),
  DataModel("Loading...", "https://i.imgur.com/SngRPqe.jpg", "Loading content..."),
  DataModel("Loading...", "https://i.imgur.com/SngRPqe.jpg", "Loading content..."),
  DataModel("Loading...", "https://i.imgur.com/SngRPqe.jpg", "Loading content..."),
];

  List<DataModel> RecommendedDataList= [
  DataModel("Loading...",
             "https://i.imgur.com/SngRPqe.jpg",
            "Loading content..."),
  DataModel("Loading...", "https://i.imgur.com/SngRPqe.jpg", "Loading content..."),
  DataModel("Loading...", "https://i.imgur.com/SngRPqe.jpg", "Loading content..."),
  DataModel("Loading...", "https://i.imgur.com/SngRPqe.jpg", "Loading content..."),
];
  
  @override
  void initState() {
    super.initState();
    _getPost();
  }  
  
  void _getPost() async{
        http.Response response = await http.post(
        Uri.parse(PostApiConstants.baseUrl+PostApiConstants.usersEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
        );

        if(response.statusCode==200){
          var data=response.body;
          var pdata=json.decode(data);
          var RecommendedData=pdata["Recommended"];
          var AllPost=pdata["Post"];



          List<DataModel> AllPostList=[];
          for(int i=0;i<AllPost["Title"].length;i++){
            AllPostList.add(DataModel("""${AllPost['Title']['$i']}""", "${AllPost['imageName']['$i']}", "${AllPost['description']['$i']}"));
            //AllPostList.add({"title":"${AllPost["Title"]['$i']}","imageName":"${AllPost["imageName"]['$i']}","description":"${AllPost["description"]['$i']}"});
          }

          List<DataModel> RecommendedPostList=[];
          for(int i=0;i<RecommendedData["Title"].length;i++){
            RecommendedPostList.add(DataModel("""${RecommendedData['Title']['$i']}""", "${RecommendedData['imageName']['$i']}", "${RecommendedData['description']['$i']}"));
          }


          dataList=AllPostList;
          RecommendedDataList=RecommendedPostList;
          
        }
        else{

          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 70,
            decoration:  const BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: const Center(
              child: Text( 
                'Something went wrong!! Please try again',
                style:TextStyle(fontWeight:FontWeight.bold)
            ),
          ),)

          ));

          Future.delayed(const Duration(seconds:5),() {});
        }
    }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<Widget> imageSliders = RecommendedDataList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(6.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                child: InkWell(
                  onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>PostDetailsScreen(
                    datalist:item))
                );
            },
                  child: Hero(
                    tag: '${item.title}a',
                    child: Stack(
                      children: <Widget>[
                        Image.network(item.imageName, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(197, 66, 80, 113),
                                  Color.fromARGB(0, 48, 162, 237)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${item.title}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ))
    .toList();




    return SingleChildScrollView(
      child: 
      
      Column( 
        children: <Widget>[
         
          Container( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            
              children:[
                const SizedBox(height:10),
                CustomHeader(title: "Recommended",)

            ]),
          )
        
          , 
        Container(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: RecommendedDataList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.indigoAccent)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
            


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children:[
              const SizedBox(height:10),
              CustomHeader(title: "All Stories",),

              _PostMasonryGrid(
                
                dataList:dataList
              ),

            ]
          ),



          
      ]),
      
    );

  }
}

class _PostMasonryGrid extends StatelessWidget {
  const _PostMasonryGrid({
    Key key,
    this.MasonryCardHeight=const [200,250,300],
    this.dataList
  }) : super(key: key);

  final List<double> MasonryCardHeight;

  final List<DataModel> dataList;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: dataList.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
         itemBuilder: (context,index){

          DataModel datalist=dataList[index];
          
          return InkWell(
            onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>PostDetailsScreen(
                    datalist:datalist))
                );
            },
            child: Column(
              children:[
                Hero(
                  tag: '${datalist.title}',
                  child: Container(
                    height:MasonryCardHeight[index %3],
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(15.0),
                      image: DecorationImage(image: NetworkImage(datalist.imageName),
                      fit: BoxFit.cover
                      )
                    ),
                          
                  ),
                ),
                Text(
                  """${datalist.title}""",
                  maxLines: 3,
                  style:Theme.of(context).textTheme.bodyMedium.copyWith(
                    color:Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  )
             ]
            ),
          );
         }

         );
  }
}

class PostApiConstants {
  static String baseUrl = 'http://ec2-54-147-236-46.compute-1.amazonaws.com';
  static String usersEndpoint = '/post';
}