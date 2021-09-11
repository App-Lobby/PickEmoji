# 🤯 PickEmoji: A SwiftUI Extension to Pick the Emojis that you wish

You can use this library in your projects🙃 . You can search the emojis too. **Below GIF tells you the most of it**

## 🎥 Preview

![Alt Text](https://github.com/myawesomehub/PickEmoji/blob/main/LibraryPriview/Priview.gif)

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

| Features                                       | Status |
|------------------------------------------------|--------|
| `Multi Platform Supports(iPad, macOS, iWatch)` |`false` |
| `Appearance (Dark & Light)`                    |`false` |
| `Multiple Emoji Selection`                     |`false` |

## About API

I am using an API for fetching the emojies: https://api.emojisworld.fr/v1

## About Me


LinkedIn: [@in/my-pro-file](https://www.linkedin.com/in/my-pro-file/) <br />
GitHub: [@myawesomehub](https://github.com/myawesomehub)<br />
Twitter: [@mohdYasir03](https://twitter.com/mohdYasir03)<br />
Medium: [@mdcode2021](https://medium.com/@mdcode2021)<br />


<!-- 
|Platforms | Links                                                          |
|----------|----------------------------------------------------------------|
|`LinkedIn`  |[@in/my-pro-file](https://www.linkedin.com/in/my-pro-file/)   |
|`GitHub`    |[@myawesomehub](https://github.com/myawesomehub)              |
|`Twitter`   |[@mohdYasir03](https://twitter.com/mohdYasir03)               |
|`Medium`    |[@mdcode2021](https://medium.com/@mdcode2021)                 | -->
