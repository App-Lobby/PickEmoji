import SwiftUI

public struct PickEmoji: View {
    @ObservedObject var mainViewModel: MainViewModel = MainViewModel()
    @State public var numberOfEmojiPerRow: Int
    public var completionHandler: ((String) -> Void)

    public init(numberOfEmojiPerRow: Int, completionHandler: @escaping (String) -> Void) {
        self.numberOfEmojiPerRow = numberOfEmojiPerRow
        self.completionHandler = completionHandler
    }

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                TextField("Search Emoji", text: $mainViewModel.emojiSearch)
                    .foregroundColor(.black)
            }
            .padding(.vertical)
            .padding(.horizontal)
            .background(Color.init(hex: "#EFF1F4"))
            .cornerRadius(10)
            .padding(.vertical, 16)

            LazyVGrid(columns: Array(repeating: GridItem(), count: numberOfEmojiPerRow), spacing: 20) {
                ForEach(mainViewModel.emojis, id: \.id) { item in
                    Text(item.emoji)
                        .onTapGesture {
                            completionHandler(item.emoji)
                        }
                }
            }

        }
        .padding(20)
        .background(Color.init(hex: "#FAFAFA"))
        .alert(isPresented: $mainViewModel.showError) {
            Alert(title: Text(mainViewModel.errorTitle), message: Text(mainViewModel.errorMessage), dismissButton: .cancel())
        }

    }
}

struct Response: Decodable {
    var results: [Emoji]
}

struct Emoji: Decodable, Hashable {
    var id = UUID()
    var emoji: String

    private enum CodingKeys: String, CodingKey {
        case emoji
    }
}

class EmojiServiceManager {

    enum NetworkError: Error {
        case emojiNotFound
        case timeOut
        case wrongURL
    }

    enum NetworkMethods: String {
        case GET = "GET"
        case POST = "POST"
    }

    static func makeEmojiApiCall (
        for query: String,
        limit: Int,
        completionHandler: @escaping (Result<Response, NetworkError>) -> ()
    ) {
        let url = "https://api.emojisworld.fr/v1/search?q=\(query)&limit=\(limit)"
        guard let safeURL = URL(string: "\(url)") else {
            completionHandler(.failure(NetworkError.wrongURL))
            return
        }

        var request = URLRequest(url: safeURL)
        request.httpMethod = NetworkMethods.GET.rawValue

        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(NetworkError.timeOut))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Response.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(NetworkError.emojiNotFound))
            }
        }.resume()
    }

}

class MainViewModel: ObservableObject {

    @Published var emojiSearch: String = "" {
        didSet {
            fetchEmoji()
        }
    }

    @Published var emojis: [Emoji] = []

    @Published var showError = false
    @Published var errorTitle: String = "Make Sure to Connect With Internate"
    @Published var errorMessage: String = ""

    init() {
        self.fetchEmoji()
    }

    private func fetchEmoji() {
        let searchText = self.emojiSearch.isEmpty ? "smile" : self.emojiSearch
        EmojiServiceManager.makeEmojiApiCall(for: searchText, limit: 100) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.emojis = data.results
                }
            case .failure(let error):
                switch error {
                case .emojiNotFound:
                    DispatchQueue.main.async {
                        self.errorMessage = "\(error.localizedDescription.description)"
                        self.showError = true
                    }
                case .timeOut:
                    DispatchQueue.main.async {
                        self.errorMessage = "\(error.localizedDescription.description)"
                        self.showError = true
                    }
                case .wrongURL:
                    DispatchQueue.main.async {
                        self.errorMessage = "\(error.localizedDescription.description)"
                        self.showError = true
                    }
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


