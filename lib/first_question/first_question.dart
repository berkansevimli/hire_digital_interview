import 'package:flutter/material.dart';

class FirstQuestion extends StatefulWidget {
  const FirstQuestion({Key? key}) : super(key: key);

  @override
  State<FirstQuestion> createState() => _FirstQuestionState();
}

class _FirstQuestionState extends State<FirstQuestion> {
  List<Map> usersList = [
    {
      'id': 1,
      'user_name': "Alice",
      'friends': [3, 5]
    },
    {
      'id': 2,
      'user_name': "Eve",
      'friends': [3, 4, 5]
    },
    {
      'id': 3,
      'user_name': "Bob",
      'friends': [1, 2, 4]
    },
    {
      'id': 4,
      'user_name': "Charlie",
      'friends': [3]
    },
    {
      'id': 5,
      'user_name': "Dan",
      'friends': [1, 2]
    },
  ];
  List recommends = [];
  List<Map> scoreMap = [];
  List friendsIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                getFriendsList(1); // original userID
                print(friendsIds);
                getRecommendedList(friendsIds, 1,
                    1); // current user's friend list, original userID, filter parameter: k
              },
              child: Text("Get Recommonded List"))
        ],
      )),
    );
  }

  getFriendsList(int userID) {
    //Get original user's friend list
    friendsIds =
        usersList.where((element) => element['id'] == userID).first['friends'];
    setState(() {});
  }

  getRecommendedList(List friendsList, int userID, int k) {
    friendsList.forEach((userElement) {
      // get friends list of original user's friends
      List currentList = usersList
          .where((element) => element['id'] == userElement)
          .first['friends'];

      currentList.forEach((element) {
        // check user's friends - if he/she is friend or not with org. user
        if (!friendsList.contains(element) && element != userID) {
          // check existance scoreMap. if is not exist add user to scoreMap
          final value = scoreMap.where((a) => a['id'] == element);
          if (value.isEmpty) {
            print("No record with $element");
            // if it is not exist add user to scoreMap and set score 1
            scoreMap.add({'id': element, 'score': 1});
          } else {
            // if it exist update score
            scoreMap
                .where((scoreElement) => scoreElement['id'] == element)
                .first['score'] = scoreMap
                    .where((scoreElement) => scoreElement['id'] == element)
                    .first['score'] +
                1;
          }
        }
        setState(() {});
      });
    });

    /// filter results with k variable. The k value shows how many mutual friends the user has. And score is same meaning.
    List resultsList =
        scoreMap.where((element) => element['score'] <= k).toList();
    resultsList.forEach((element) {
      //get username from userList
      String username =
          usersList.where((e) => e['id'] == element['id']).first['user_name'];
      print(username);
    });
  }
}
