import 'package:flutter/material.dart';

class GptQueryPage extends StatefulWidget {
  @override
  _GptQueryPageState createState() => _GptQueryPageState();
}

class _GptQueryPageState extends State<GptQueryPage> {
  TextEditingController _inputController = TextEditingController();
  String _response = '';
  String _error = '';
  bool _isLoading = false;
  //final GptService _gptService = GptService();

  void _getGptResponse() async {
    setState(() {
      _isLoading = true;
      _response = '';
      _error = '';
    });

    try {
      String userInput = _inputController.text;
      //String response = await _gptService.getChatGptResponse(userInput);
      setState(() {
        //   _response = response;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT-3.5 Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter your query',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _getGptResponse,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Get Response'),
            ),
            SizedBox(height: 20),
            if (_response.isNotEmpty)
              Text(
                'Response:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            if (_response.isNotEmpty)
              Text(
                _response,
                style: TextStyle(fontSize: 16),
              ),
            if (_error.isNotEmpty)
              Text(
                'Error:',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

/*-----------------------------BURASI KALACAKK------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/gpt/service/gpt_service.dart';

class GptQueryPage extends StatefulWidget {
  @override
  _GptQueryPageState createState() => _GptQueryPageState();
}

class _GptQueryPageState extends State<GptQueryPage> {
  TextEditingController _inputController = TextEditingController();
  String _response = '';
  String _error = '';
  bool _isLoading = false;
  final GptService _gptService = GptService();

  void _getGptResponse() async {
    setState(() {
      _isLoading = true;
      _response = '';
      _error = '';
    });

    try {
      String userInput = _inputController.text;
      String response = await _gptService.getChatGptResponse(userInput);
      setState(() {
        _response = response;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT-3.5 Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter your query',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _getGptResponse,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Get Response'),
            ),
            SizedBox(height: 20),
            if (_response.isNotEmpty)
              Text(
                'Response:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            if (_response.isNotEmpty)
              Text(
                _response,
                style: TextStyle(fontSize: 16),
              ),
            if (_error.isNotEmpty)
              Text(
                'Error:',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
--------------------burası kalacakkkkkkkk---------------*/




/*
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/gpt/service/gpt_service.dart';

class GptQueryPage extends StatefulWidget {
  @override
  _GptQueryPageState createState() => _GptQueryPageState();
}

class _GptQueryPageState extends State<GptQueryPage> {
  TextEditingController _inputController = TextEditingController();
  String _response = '';
  String _error = '';
  bool _isLoading = false;
  final GptService _gptService = GptService();

  void _getGptResponse() async {
    setState(() {
      _isLoading = true;
      _response = '';
      _error = '';
    });

    try {
      String userInput = _inputController.text;
      String response = await _gptService.getChatGptResponse(userInput);
      setState(() {
        _response = response;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT-3.5 Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter your query',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _getGptResponse,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Get Response'),
            ),
            SizedBox(height: 20),
            if (_response.isNotEmpty)
              Text(
                'Response:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            if (_response.isNotEmpty)
              Text(
                _response,
                style: TextStyle(fontSize: 16),
              ),
            if (_error.isNotEmpty)
              Text(
                'Error:',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
*/










/*
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/gpt/service/gpt_service.dart';

class GptQueryPage extends StatefulWidget {
  @override
  _GptQueryPageState createState() => _GptQueryPageState();
}

class _GptQueryPageState extends State<GptQueryPage> {
  TextEditingController _inputController = TextEditingController();
  String _response = '';
  bool _isLoading = false;
  final GptService _gptService = GptService();

  void _getGptResponse() async {
    setState(() {
      _isLoading = true;
      _response = '';
    });

    String userInput = _inputController.text;
    String response = await _gptService.getChatGptResponse(userInput);

    setState(() {
      _isLoading = false;
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT-3.5 Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter your query',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _getGptResponse,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Get Response'),
            ),
            SizedBox(height: 20),
            if (_response.isNotEmpty)
              Text(
                'Response:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            if (_response.isNotEmpty)
              Text(
                _response,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
*/
