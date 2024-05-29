# iOS-Small_Apps
Sample applications to highlight specific iOS development features in each app


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

### Speed Test
**Description**: 
Performs internet speed test utilizing a custom circular progress bar and `SpeedcheckerSDK 2.0.3`

**Additional**:
1. SpeedcheckerSDK API Documentation: https://github.com/speedchecker/speedchecker-sdk-ios/wiki/API-documentation
2. Customized Circular Progress View: to display upload and download progress during speed test
