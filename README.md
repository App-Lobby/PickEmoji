# 🤯 PickEmoji: A SwiftUI Extension to Pick the Emojis that you wish

You can use this library in your projects🙃 . You can search the emojis too. **Below GIF tells you the most of it**

## 🎥 Priview

## 🤔 How to Use?

You can just start using this libary by importing it in your project as a package and then writing these below code

```swift
import SwiftUI
import PickEmoji

struct ContentView: View {
    @State var selectedEmoji = "No Emoji"
    
    var body: some View {
        PickEmoji(numberOfEmojiPerRow: 6) { emoji in
            selectedEmoji = emoji
        }
    }
}
  ```
Not only that, You can customize the view as you wish. Try the below code 

```swift
import SwiftUI
import PickEmoji

struct ContentView: View {
    @State var selectedEmoji = "No Emoji"

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                PickEmoji(numberOfEmojiPerRow: 6) { emoji in
                    selectedEmoji = emoji
                }
            }
            .frame(maxHeight: 400)
            .cornerRadius(14)

            Spacer()

            HStack {
                Text("Selected Emoji: ")
                Text(selectedEmoji)
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.4), radius: 12, x: 6, y: 6)
        }
        .padding()
    }
}
  ```

## 🤗 Contributing

PickEmoji welcomes the contributing by opening an issue or creating a pull request.

## 🚀 Things You can Work and Contribute on

| Features                                       | Status |
|------------------------------------------------|--------|
| `Multi Platform Supports(iPad, macOS, iWatch)` |`false` |
| `Appearance (Dark & Light)`                    |`false` |


