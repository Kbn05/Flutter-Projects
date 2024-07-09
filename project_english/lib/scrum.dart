import 'package:flutter/material.dart';

class scrumInfoPage extends StatefulWidget {
  @override
  _scrumInfoPageState createState() => _scrumInfoPageState();
}

class _scrumInfoPageState extends State<scrumInfoPage> {
  bool _advantageExpanded = false;
  bool _disadvantageExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrum framework'),
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
        'Scrum Methodology',
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
      'Scrum helps people and teams deliver value incrementally in a collaborative way. As an agile framework, Scrum provides just enough structure for people and teams to integrate into how they work, while adding the right practices to optimize for their specific needs. Scrum is an empirical process, where decisions are based on observation, experience and experimentation. Scrum has three pillars: transparency, inspection and adaptation. This supports the concept of working iteratively. Think of empiricism as working through small experiments, learning from that work and adapting both what you are doing and how you are doing it as needed.',
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
                  '• Flexibility and Adaptability: Scrum is highly adaptable to changes. Requirements can evolve and change, which is useful in dynamic environments.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Improved Team Collaboration and Communication: Daily stand-up meetings and regular sprints encourage constant communication, improving team collaboration.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Faster Delivery of Value: Working in short sprints means that product increments are delivered frequently, providing faster value to stakeholders.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Continuous Improvement: Retrospectives at the end of each sprint promote continuous improvement, allowing teams to reflect and enhance their processes.',
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
                  '• Flexibility and Adaptability: Scrum is highly adaptable to changes. Requirements can evolve and change, which is useful in dynamic environments.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Improved Team Collaboration and Communication: Daily stand-up meetings and regular sprints encourage constant communication, improving team collaboration.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Faster Delivery of Value: Working in short sprints means that product increments are delivered frequently, providing faster value to stakeholders.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  '• Continuous Improvement: Retrospectives at the end of each sprint promote continuous improvement, allowing teams to reflect and enhance their processes.',
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
