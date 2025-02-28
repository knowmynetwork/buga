import 'export.dart';


// Loading Screen
class LoadingScreen extends StatefulWidget { // Use StatefulWidget
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true; // Local state variable

  @override
  void initState() {
    super.initState();
    someAsynchronousOperation(); // Call it here
  }

  Future<void> someAsynchronousOperation() async {
    // Simulate some work
    await Future.delayed(const Duration(seconds: 2));

    // Example: Fetching data (replace with your actual API call)
    // try {
    //   final data = await fetchData(); // Your data fetching function
    //   setState(() {
    //     isLoading = false;
    //   });
    // } catch (e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   rethrow; // Re-throw the error to be caught by FutureBuilder
    // }

    setState(() { // Set the state to rebuild the widget
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Use Scaffold here
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading ? const LoadingIndicator() : const Text("Setup Complete!", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

// Loading Indicator Widget (No longer needs ref)
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          // ignore: deprecated_member_use
          backgroundColor: Colors.yellow.withOpacity(0.2),
        ),
        const SizedBox(height: 24),
        const Text(
          'Just a sec',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Setting you up...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}