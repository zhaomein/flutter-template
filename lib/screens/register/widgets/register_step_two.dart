import 'package:com.ourlife.app/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterStepTwo extends StatefulWidget {
  @override
  _RegisterStepTwoState createState() => _RegisterStepTwoState();
}

class _RegisterStepTwoState extends State<RegisterStepTwo> {
  DateTime _currentDate;

  void _openDatePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 280,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text(AppLg.of(context).trans('cancel'), style: TextStyle(color: Colors.blue)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                        child: Text(
                            AppLg.of(context).trans('done'),
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
                        ),
                        onPressed: () {
                          if(_currentDate == null) {
                            setState(() {
                              _currentDate = DateTime(1970);
                            });
                          }
                          Navigator.of(context).pop();
                        }
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    maximumYear: DateTime.now().year - 14,
                    minimumYear: 1970,
                    initialDateTime: _currentDate ?? DateTime(1970),
                    onDateTimeChanged: (date) {
                      setState(() {
                        _currentDate = date;
                      });
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  void _nextStep(context) {

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50, left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Center(
               child: Text(AppLg.of(context).trans('birthday'),
                   style: TextStyle(
                       fontWeight: FontWeight.w700,
                       color: Colors.blue,
                       fontSize: 40
                   )
               ),
             ),
             SizedBox(height: 30),
             CupertinoButton(
               onPressed: () => _openDatePicker(context),
               child: Container(
                 decoration: BoxDecoration(
                     border: Border(
                         bottom: BorderSide(
                             color: Colors.grey,
                             width: 2
                         )
                     )
                 ),
                 child: Center(
                   child:  Text(
                       _currentDate != null ? "${_currentDate.month.toString().padLeft(2, '0')}/${_currentDate.day.toString().padLeft(2, '0')}/${_currentDate.year}" : "",
                       style: TextStyle(
                           fontWeight: FontWeight.w700,
                           fontSize: 20
                       )
                   ),
                 ),
               ),
             ),
             SizedBox(height: 80),
             Center(
               child: CupertinoButton(
                 color: Colors.blue,
                 borderRadius: BorderRadius.all(Radius.circular(15)),
                 onPressed: () => _nextStep(context),
                 child: Text(
                   AppLg.of(context).trans('continue'),
                   style: TextStyle(color: Colors.white),
                 ),
               ),
             )
           ]
        )
      )
    );
  }
}