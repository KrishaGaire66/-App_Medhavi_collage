// import 'package:flutter/material.dart';
// import 'package:medhavi/screen/menuitems/components/menu_items.dart';

// import 'package:medhavi/screen/profilescreen/components/profilescreen.dart';
// import 'package:medhavi/utils/colors.dart';

// class MenuScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: linearGradient1,
//             ),
//           ),
//           title: Text('Menu'),
//           elevation: 0,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 12.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ProfileScreen()),
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.person, color: secondaryColor),
//                 ),
//               ),
//             )
//           ],
//         ),
        
//       ),
      
//       body: Padding(
//   padding: const EdgeInsets.only(top: 10.0), // Adjust height as needed
//   child: ListView.builder(
//     itemCount: menuItems.length,
//     itemBuilder: (context, index) {
//       return Card(
//         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: ListTile(
//           leading: Icon(menuItems[index].icon, color: primaryColor),
//           title: Text(menuItems[index].title),
//           subtitle: Text(menuItems[index].subtitle),
//           trailing: Icon(Icons.arrow_forward_ios, size: 16, color: primaryColor),
//           onTap: () {
//             // Handle navigation or action
//           },
//         ),
//       );
//     },
//   ),
// ),

//     );
//   }
// }
