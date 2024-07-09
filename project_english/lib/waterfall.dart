import 'package:flutter/material.dart';

class waterfallInfoPage extends StatefulWidget {
  @override
  _waterfallInfoPageState createState() => _waterfallInfoPageState();
}

class _waterfallInfoPageState extends State<waterfallInfoPage> {
  bool _advantageExpanded = false;
  bool _disadvantageExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waterfall methodology'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildDescription(),
            SizedBox(height: 20),
            _buildAdvantageSection(),
            SizedBox(height: 20),
            _buildDisadvantageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Waterfall Methodology',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'The Waterfall model is a linear and sequential approach to software development. It involves a series of stages: requirements gathering, system design, implementation, testing, deployment, and maintenance. Each phase must be completed before moving to the next, with little room for changes once a phase is completed.',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildAdvantageSection() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _advantageExpanded = !_advantageExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                'Advantage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: const ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• The linear approach is straightforward and easy to understand and manage, especially for small projects with clear requirements.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Each phase has specific deliverables and a review process, making it easy to track progress and manage milestones.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Extensive documentation and planning ensure that all requirements are captured upfront, providing a clear project roadmap.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Works well for projects where requirements are unlikely to change and are well understood from the beginning.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• The rigid structure makes it easier to manage and control the project, especially for teams familiar with traditional project management practices.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          isExpanded: _advantageExpanded,
        ),
      ],
    );
  }

  Widget _buildDisadvantageSection() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _disadvantageExpanded = !_disadvantageExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                'Disadvantage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: const ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• Changes are difficult to implement once the project is underway, making it unsuitable for projects with evolving requirements.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Testing is deferred until after the implementation phase, potentially leading to more defects being discovered later in the development cycle.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• High risk and uncertainty due to the lack of flexibility and delayed feedback. Problems are often discovered late in the process.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Inability to adapt to changes in customer requirements or market conditions can result in a product that is outdated or irrelevant by the time it is delivered.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Higher Customer Satisfaction: Regular feedback loops ensure the product meets customer expectations, enhancing customer satisfaction.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          isExpanded: _disadvantageExpanded,
        ),
      ],
    );
  }
}
