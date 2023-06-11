
import SwiftUI

struct PokeAPI: View {
    
    @StateObject var creaturesVM = PokeAPIModel()
    
    var body: some View {
        
        NavigationStack {
            
            List(creaturesVM.creaturesArray, id: \.self, rowContent: { creature in
                
                Text(creature.name)
                    .font(.title2)
            })
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            await creaturesVM.getData()
        }
    }
}


struct PokeAPI_Previews: PreviewProvider {
    
    static var previews: some View {
        PokeAPI()
        
    }
}
