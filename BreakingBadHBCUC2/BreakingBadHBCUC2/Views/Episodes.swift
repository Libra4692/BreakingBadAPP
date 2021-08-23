//
//  Episodes.swift
//  BreakingBadApp
//
//  Created by Computer Science on 8/10/21.
//


import SwiftUI
struct Episodes: View{
    
    @State var episodes = [BBEpisodes]()
    
    var body: some View{
        
        ScrollView{
            
            HStack(alignment: .top, spacing: 12) {
                Image("breakingbad")
                    .resizable()
                    .frame(width: 90, height: 50, alignment: .trailing)
                
                Text("Episodes")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color.green"))
            }
            
            ForEach(episodes){ episodes in
                
                FlashcardSmall(front: {
                    VStack{
                        Text("Season #" + episodes.season)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("Episode #" + episodes.episode)
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
                        Text("Title: " + episodes.title)
                            .font(.system(size: 22))
                        Text("Date Aired: " + episodes.air_date)
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
        //navigationTitle("Braking Bad Quotes")
        .onAppear(perform: {
            let url = URL(string: "https://breakingbadapi.com/api/episodes")!
            URLSession.shared.dataTask(with: url){ data, _, error in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    if let data = data{
                        let decoder = JSONDecoder()
                        do{
                            let episodes = try decoder.decode([BBEpisodes].self, from: data)
                            DispatchQueue.main.async {
                                self.episodes = episodes
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

struct BBEpisodes: Decodable{
    var episode_id: Int
    var title: String
    var season: String
    var episode: String
    var air_date: String
    
}

//struct testchar {
//    var 0: String
//
//}
//


extension BBEpisodes: Identifiable{
    var id: Int{
        return episode_id
    }
    
}


