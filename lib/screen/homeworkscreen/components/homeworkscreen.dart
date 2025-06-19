import 'package:flutter/material.dart';
import 'package:medhavi/utils/colors.dart'; // Assuming you have this

class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'My Homework',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Colors.white,
            child:             TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Submitted'),
                Tab(text: 'Graded'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingTab(),
          _buildSubmittedTab(),
          _buildGradedTab(),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   backgroundColor: primaryColor,
      //   icon: Icon(Icons.add),
      //   label: Text('Add Homework'),
      // ),
    );
  }

  Widget _buildPendingTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Add refresh logic
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildStatsCards(),
          SizedBox(height: 20),
          _buildSectionTitle('Due Soon', Icons.schedule),
          SizedBox(height: 12),
          _buildHomeworkCard(
            title: 'Mathematics Assignment #5',
            subject: 'Mathematics',
            dueDate: 'Due Tomorrow',
            priority: 'High',
            description: 'Solve exercises 1-15 from Chapter 8',
            isUrgent: true,
          ),
          _buildHomeworkCard(
            title: 'Science Project Report',
            subject: 'Science',
            dueDate: 'Due in 3 days',
            priority: 'Medium',
            description: 'Research and write about renewable energy sources',
          ),
          SizedBox(height: 20),
          _buildSectionTitle('This Week', Icons.calendar_today),
          SizedBox(height: 12),
          _buildHomeworkCard(
            title: 'English Essay',
            subject: 'English',
            dueDate: 'Due Friday',
            priority: 'Low',
            description: 'Write 500 words on "Climate Change Impact"',
          ),
        ],
      ),
    );
  }

  Widget _buildSubmittedTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildSubmittedCard(
          title: 'History Assignment',
          subject: 'History',
          submittedDate: 'Submitted 2 days ago',
          status: 'Under Review',
        ),
        _buildSubmittedCard(
          title: 'Biology Lab Report',
          subject: 'Biology',
          submittedDate: 'Submitted 1 week ago',
          status: 'Reviewed',
        ),
      ],
    );
  }

  Widget _buildGradedTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildGradedCard(
          title: 'Physics Problem Set',
          subject: 'Physics',
          grade: 'A-',
          score: '85/100',
          feedback: 'Good work! Pay attention to significant figures.',
        ),
        _buildGradedCard(
          title: 'Chemistry Quiz',
          subject: 'Chemistry',
          grade: 'B+',
          score: '78/100',
          feedback: 'Well done on the organic chemistry section.',
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Pending',
            count: '5',
            color: Colors.orange,
            icon: Icons.pending_actions,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Completed',
            count: '23',
            color: Colors.green,
            icon: Icons.check_circle,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Average',
            count: '87%',
            color: primaryColor,
            icon: Icons.trending_up,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeworkCard({
    required String title,
    required String subject,
    required String dueDate,
    required String priority,
    required String description,
    bool isUrgent = false,
  }) {
    Color priorityColor = priority == 'High'
        ? Colors.red
        : priority == 'Medium'
            ? Colors.orange
            : Colors.green;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isUrgent ? Border.all(color: Colors.red.shade300, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    priority,
                    style: TextStyle(
                      fontSize: 12,
                      color: priorityColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.book, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Spacer(),
                Icon(
                  isUrgent ? Icons.warning : Icons.schedule,
                  size: 16,
                  color: isUrgent ? Colors.red : Colors.grey.shade600,
                ),
                SizedBox(width: 4),
                Text(
                  dueDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUrgent ? Colors.red : Colors.grey.shade600,
                    fontWeight: isUrgent ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.visibility, size: 18),
                    label: Text('View Details'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit, size: 18),
                    label: Text('Start Work'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmittedCard({
    required String title,
    required String subject,
    required String submittedDate,
    required String status,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.book, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(subject, style: TextStyle(color: Colors.grey.shade600)),
                Spacer(),
                Icon(Icons.check_circle, size: 16, color: Colors.green),
                SizedBox(width: 4),
                Text(
                  submittedDate,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradedCard({
    required String title,
    required String subject,
    required String grade,
    required String score,
    required String feedback,
  }) {
    Color gradeColor = grade.startsWith('A')
        ? Colors.green
        : grade.startsWith('B')
            ? Colors.blue
            : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: gradeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    grade,
                    style: TextStyle(
                      fontSize: 16,
                      color: gradeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.book, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(subject, style: TextStyle(color: Colors.grey.shade600)),
                Spacer(),
                Text(
                  score,
                  style: TextStyle(
                    color: gradeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.feedback, size: 16, color: Colors.grey.shade600),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feedback,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Homework'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'All',
            'Mathematics',
            'Science',
            'English',
            'History',
            'Physics',
            'Chemistry',
            'Biology'
          ].map((filter) => RadioListTile<String>(
            title: Text(filter),
            value: filter,
            groupValue: selectedFilter,
            onChanged: (value) {
              setState(() {
                selectedFilter = value!;
              });
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }
}