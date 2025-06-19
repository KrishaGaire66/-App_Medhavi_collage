import 'package:flutter/material.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faculty and Semester',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AddFacultyAndSemScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddFacultyAndSemScreen extends StatefulWidget {
  const AddFacultyAndSemScreen({Key? key}) : super(key: key);

  @override
  State<AddFacultyAndSemScreen> createState() => _AddFacultyAndSemScreenState();
}

class _AddFacultyAndSemScreenState extends State<AddFacultyAndSemScreen> {
  String _selectedFaculty = 'Select faculty';
  String _selectedDegree = 'Select degree';
  String _selectedSemester = 'Select semester';

  final List<String> _degrees = [
    'Bachelor',
    'Master',
  ];

  List<String> _availableFaculties = [];
  List<String> _availableSemesters = [];

  final Map<String, List<String>> _facultyOptions = {
    'Bachelor': ['BCIS', 'BBA', 'BHM'],
    'Master': ['MCSIT', 'MBA'],
  };

  void _showDegreeBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: 200,
          child: Column(
            children: [
              const Text(
                'Select Degree',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _degrees.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_degrees[index]),
                      onTap: () {
                        setState(() {
                          _selectedDegree = _degrees[index];
                          _selectedFaculty = 'Select faculty';
                          _selectedSemester = 'Select semester';

                          _availableFaculties =
                              _facultyOptions[_selectedDegree] ?? [];

                          _availableSemesters = _selectedDegree == 'Master'
                              ? ['I Semester', 'II Semester', 'III Semester', 'IV Semester']
                              : ['I Semester', 'II Semester', 'III Semester', 'IV Semester', 'V Semester', 'VI Semester', 'VII Semester', 'VIII Semester'];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFacultyBottomSheet() {
    if (_availableFaculties.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a degree first')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: 300,
          child: Column(
            children: [
              const Text(
                'Select Faculty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white,),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _availableFaculties.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_availableFaculties[index],style: TextStyle(color: Colors.white,),),
                      onTap: () {
                        setState(() {
                          _selectedFaculty = _availableFaculties[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSemesterBottomSheet() {
    if (_availableSemesters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a degree first')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: 300,
          child: Column(
            children: [
              const Text(
                'Select Semester',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _availableSemesters.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_availableSemesters[index]),
                      onTap: () {
                        setState(() {
                          _selectedSemester = _availableSemesters[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectionContainer(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: title.contains('Select') ? Colors.grey[600] : Colors.black,
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Faculty and Semester',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Degree',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _showDegreeBottomSheet,
              child: _buildSelectionContainer(_selectedDegree),
            ),
            const SizedBox(height: 20),
            const Text(
              'Faculty',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _showFacultyBottomSheet,
              child: _buildSelectionContainer(_selectedFaculty),
            ),
            const SizedBox(height: 20),
            const Text(
              'Semester',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _showSemesterBottomSheet,
              child: _buildSelectionContainer(_selectedSemester),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
  text: 'Add',
  onPressed: () {
    if (_selectedFaculty != 'Select faculty' &&
        _selectedDegree != 'Select degree' &&
        _selectedSemester != 'Select semester') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Faculty, Degree and Semester added successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
    }
  },
),

            ),
          ],
        ),
      ),
    );
  }
}
