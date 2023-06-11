
import Foundation
import SwiftUI

class PokeAPIModel : ObservableObject {
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Result]
    }
    
    struct Result: Codable, Hashable {
        var name: String
        var url: String
    }
    
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var creaturesArray: [Result] = []
    
    func getData() async {
        
        print("we are accessing the url\(urlString)")
        guard let url = URL(string: urlString) else {
            print("Error \(urlString)")
            return
        }
        do {
            let (date, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: date) else {
                print("JSON error")
                return
            }
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("Error\(urlString)")
        }
    }
}
