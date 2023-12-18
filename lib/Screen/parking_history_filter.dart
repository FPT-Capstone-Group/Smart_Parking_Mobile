import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/Screen/parking_history_detail.dart';
import 'package:parking_auto/controller/parking_history.dart';
import 'package:parking_auto/model/parking_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => new _DemoState();
}

class _DemoState extends State<Demo> {
  //DateRangePickerController _datePickerController = DateRangePickerController();
  ParkingSessionController getData = ParkingSessionController();
  List<Data>? listData;
  bool textVisible = false;
  String date = "Time: 7 days ago to time now";
  String result = " ";
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    
    super.initState();
    setDefaultDate();
    fetchData();
  
  }

  @override
  Widget build(BuildContext context) {
    final list = listData;
    if(list == null){
      result = "Result: non data in time";
    }else{
      result = "Result: " + list.length.toString() + " records";
    }
   
    return Scaffold(
        appBar: AppBar(centerTitle: true,
  title: Text('Parking History'),
  leading: IconButton(
    onPressed: () {
      Get.to(HomePage());
    },
    icon: Icon(Icons.home),),
    actions: [
      Icon(Icons.history)
    ],),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        
                        alignment: Alignment.center,
                        //width: double.infinity,
                        width: 250,
                        height: 20,
                        color: Colors.grey[300],
                        child:Text(date),
          // Displays the date on the screen
                      ),
 const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        //width: double.infinity,
                        width: 190,
                        height: 20,
                        color: Colors.grey[300],
                        child:Text(result),
                      ),
                      //Container(height: 10),
                      const Divider(
                        color: Colors.green,
                        height: 20,
                      ),
                      Container(
                        //alignment: Alignment.center,
                        child: FloatingActionButton.extended(
                           
                            onPressed: () {
                              selectDateTimeRange();
                              textVisible = true;
                           
                            },
                            icon: Icon(Icons.date_range),
                            label: const Text("Select Range Date",
                                style: TextStyle(color: Colors.white))),
                      ),
                    ]),

                    //  Container(height: 10),
                    // const Divider(color: Colors.green,height: 20,),
                  ]),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Expanded(
                  child : list == null ?
                  Text("No date") :
                    

                  ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final item = list[index];
                            return InkWell(
                              onTap: () async {
                                final needReload =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ParkingHistoryDetail(item),
                                  ),
                                );
                                if (needReload == true) {
                                  // Reload data
                                  fetchData();
                                }
                              },
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                         
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "In:  ${item.checkinTime}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),

                                          item.checkoutTime != "Invalid date" ?
                                          Text(
                                            "Out: ${item.checkoutTime}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ) : Text(
                                            "Parking",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/logo.png",
                                        height: double.infinity,
                                        fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ) ,
            ])));
  }

  void fetchData() async {
    listData = null;
    if (mounted) setState(() {});
    try {
      final value = await getData.fetchData();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }

  void selectDateTimeRange() async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedDateRange = await showDateRangePicker(
      context: context,
      saveText: "Select",
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    if (selectedDateRange == null) {
      final df = new DateFormat('yyyy-MM-dd');
      DateTime.now();
      var endDate = df.format(DateTime.now());
      var dateStart = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);
      // print("------");
      // print(DateTime.now());
      // print(dateStart);
      // print("-----");
      prefs.setString('dataStart', dateStart.toString());
      prefs.setString('dateEnd', endDate.toString());
      date = "Time: 7 days ago to time now";
    
      setState(() {
        fetchData();
      });
      return;
    }
    
    if (selectedDateRange.duration.inDays == 0) {
      date = "The max picked range day is 7 days";

      final df = new DateFormat('yyyy-MM-dd');
      //print(df.format(selectedDateRange.start));
      String startDate = df.format(selectedDateRange.start);


      var endDate = DateTime(selectedDateRange.start.year, selectedDateRange.start.month, selectedDateRange.start.day,selectedDateRange.start.hour,selectedDateRange.start.minute,selectedDateRange.start.microsecond + 86399);
     // print(endDate);
      prefs.setString('dataStart', startDate.toString());
      prefs.setString('dateEnd', endDate.toString());

      date = "Time: " +startDate;
      result = "Result: on data in time";
      setState(() {
        fetchData();
         if(listData == null){
          result = "Result: on data in time";
        }
      });
      return;
    }

    if (selectedDateRange.duration.inDays > 7) {
      date = "The max range day is 7 days";

      final df = new DateFormat('yyyy-MM-dd');
      //print(df.format(selectedDateRange.start));
      String startDate = df.format(selectedDateRange.start);


      var endDate = DateTime(selectedDateRange.start.year, selectedDateRange.start.month, selectedDateRange.start.day,selectedDateRange.start.hour,selectedDateRange.start.minute,selectedDateRange.start.microsecond + 86399);
      //print(endDate);
      prefs.setString('dataStart', startDate.toString());
      prefs.setString('dateEnd', endDate.toString());

      date = "Time: " + startDate;
      date = "The max picked range day is 7 days";
      result = "Result: 0 records";
      setState(() {
        fetchData();
         if(listData == null){
          result = "Result: no data in time";
        }
      });
      return;
    }


    if (mounted) {
      final df = new DateFormat('yyyy-MM-dd');

      //print(df.format(selectedDateRange.start));
      String startDate = df.format(selectedDateRange.start);
      // print(startDate);
      String endDate = df.format(selectedDateRange.end);
      date = startDate + " to " + endDate;
      prefs.setString('dataStart', startDate);
      prefs.setString('dateEnd', endDate);

      

       
      setState(() {
        fetchData();
        if(listData == null){
          result = "Result: no data in time";
        }
        date = "Time: " +startDate + " to " + endDate;
      });

    }
    setState(() {
      this.selectedDateRange = selectedDateRange;
    });
  }

  setDefaultDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final df = new DateFormat('yyyy-MM-dd');
    //var endDate = df.format(DateTime.now());
    var endDate = DateTime.now();
   // print(endDate);
    var dateStart = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day - 7,DateTime.now().hour,DateTime.now().minute,DateTime.now().microsecond );
    prefs.setString('dataStart', dateStart.toString());
    prefs.setString('dateEnd', endDate.toString());
    date = "Time: 7 day ago to time now";
  }
}