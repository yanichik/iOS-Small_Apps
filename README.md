# iOS-Small_Apps
Sample applications to highlight specific iOS development features in each app

### Speed Test
**Description**: 
Performs internet speed test utilizing `SpeedcheckerSDK 2.0.3` for speed test, IODA Open API for outage summary, and a customized circular progress bar to display speed test progress

**Additional**:
1. SpeedcheckerSDK API Documentation: https://github.com/speedchecker/speedchecker-sdk-ios/wiki/API-documentation
2. Customized Circular Progress View: to display upload and download progress during speed test
3. IODA Project Info for internet outage detection and analysis: https://ioda.inetintel.cc.gatech.edu/project
4. IODA Open API: https://api.ioda.inetintel.cc.gatech.edu/v2/

### Result App
**Description**: 
Demonstrate use of `Result enum` for handling network call result including decoded data and custom error

### Core Data Demo
**Description**: 
Tableview of Person types displays list of names

**Additional**: 
1. Uses `NSPredicate` to filter Core Data. Predicate format must be written such that can be read by SQLite
   - Article on how SQLite surprises when faced with `nil`: https://douglashill.co/nspredicate-null-inequality/
   - Apple Documentation: https://developer.apple.com/documentation/foundation/nspredicate
   - Apple Detailed Guide: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/AdditionalChapters/Introduction.html
