//
//  Deaths.swift
//  BreakingBadHBCUC2
//
//  Created by Computer Science on 8/11/21.
//

import SwiftUI
struct Deaths: View{
    @State var deaths = [BBDeaths]()
    var body: some View{
        
        ScrollView{
            
            HStack(alignment: .top, spacing: 12) {
                Image("breakingbad")
                    .resizable()
                    .frame(width: 90, height: 50, alignment: .trailing)
                
                Text("Deaths")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color.green"))
            }
            
            ForEach(deaths){ deaths in
                
                FlashcardSmall(front: {
                    VStack{
                        Text("Season #" + String(deaths.season))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("Episode #" + String(deaths.episode))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("More Info >")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Color.green"))
                            .clipShape(Capsule())
                            .padding()
                    }
                }, back: {
                    VStack{
                        Text("Died: " + deaths.death)
                            .font(.system(size: 22))
                        Text("Cause: " + deaths.cause)
                            .font(.system(size: 22))
                        Text("Responsible: " + deaths.responsible)
                            .font(.system(size: 22))
                        Text("Last Words: " + deaths.last_words)
                            .font(.system(size: 22))
                        Text("HOME")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Color.green"))
                            .clipShape(Capsule())
                            .padding()
                    }
                })
            }
        }
        //navigationTitle("Braking Bad Deaths")
        .onAppear(perform: {
            let url = URL(string: "https://breakingbadapi.com/api/deaths")!
            URLSession.shared.dataTask(with: url){ data, _, error in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    if let data = data{
                        let decoder = JSONDecoder()
                        do{
                            let deaths = try decoder.decode([BBDeaths].self, from: data)
                            DispatchQueue.main.async {
                                self.deaths = deaths
                            }
                        }catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            } .resume()
        })
        
    }
}

struct BBDeaths: Decodable {
    var death_id: Int
    var death: String
    var cause: String
    var responsible: String
    var last_words: String
    var season: Int
    var episode: Int
    var number_of_deaths: Int
}
extension BBDeaths: Identifiable{
    var id: Int{
        return death_id
    }
    var numdeaths: Int{
        return number_of_deaths
    }
}



