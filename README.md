# 🤯 PickEmoji: A SwiftUI Extension to Pick the Emojis that you wish

You can use this library in your projects🙃 . You can search the emojis too. **Below GIF tells you the most of it**

# 🎥 Priview

# 🤔 How to Use?

All you need to do is this 

```swift
import SwiftUI
import PickEmoji

struct ContentView: View {
    @State var selectedEmoji = "No Emoji"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            PickEmoji(numberOfEmojiPerRow: 6) { emoji in
                selectedEmoji = emoji
            }
        }
    }
}
  ```

# 🤗 Contributing

PickEmoji welcomes the contributing by opening an issue or creating a pull request.
