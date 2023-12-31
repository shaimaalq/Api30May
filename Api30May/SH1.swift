//
//  SH1.swift
//  Api30May
//
//  Created by shaima on 12/11/1444 AH.
//

import SwiftUI

struct Quote2: Codable {
    
    var location_type : String
    var category: String
 
}


struct SH1: View {
    @State private var quotes = [Quote2]()
    
    var body: some View {
        NavigationView {
            
            List(quotes, id: \.category) { quote in
                
                VStack(alignment: .leading){
                    Text(quote.category)
                        .font(.headline)
                   Text(quote.location_type)
                 
                }
            }
            
            .navigationTitle("")
            .task{
                await fetchData()
            }
            
        }
    }
    
    func fetchData() async{
        
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/riddles") else {
            
            print("hey man THIS URL DOES NOT WORK")
            
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Quote2].self, from: data) {
                quotes  = decodedResponse
            }
        } catch {
            print("bod news... this data isn't valid ")
        }
    }
    
    
}

struct SH1_Previews: PreviewProvider {
    static var previews: some View {
        SH1()
    }
}
