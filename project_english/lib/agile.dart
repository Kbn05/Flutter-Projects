import 'package:flutter/material.dart';

class AgileInfoPage extends StatefulWidget {
  @override
  _AgileInfoPageState createState() => _AgileInfoPageState();
}

class _AgileInfoPageState extends State<AgileInfoPage> {
  bool _advantageExpanded = false;
  bool _disadvantageExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agile Methodology'),
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
        'Agile Methodology',
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
      'The Agile methodology is a project management and software development approach that emphasizes flexibility, collaboration, and customer-centricity. It is the latest model used by major companies today like Facebook, Google, Amazon, etc. It follows the iterative as well as incremental approach that emphasizes the importance of delivering a working product very quickly. Agile is not just a methodology; it’s a mindset. Agile isn’t about following specific rituals or techniques. Instead, it’s a bunch of methods that show a dedication to quick feedback and always getting better.',
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
          body: ListTile(
            title: Text(
              'Agile methodologies allow for flexibility and adaptability in responding to changes. Teams can easily adjust their plans and priorities based on evolving requirements or feedback during the project.',
              style: TextStyle(fontSize: 16),
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
          body: ListTile(
            title: Text(
              'The iterative and adaptive nature of agile can sometimes lead to uncertainty, especially in projects with unclear or rapidly changing requirements. This may pose challenges in estimating timelines and costs accurately.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          isExpanded: _disadvantageExpanded,
        ),
      ],
    );
  }
}
