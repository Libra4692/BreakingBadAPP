//
//  Quotes.swift
//  BreakingBadHBCUC2
//
//  Created by Computer Science on 8/11/21.
//

import SwiftUI
struct Quotes: View{
    
    @State var quotes = [BBQuotes]()
    
    var body: some View{
        
        ScrollView{
            
            HStack(alignment: .top, spacing: 12) {
                Image("breakingbad")
                    .resizable()
                    .frame(width: 90, height: 50, alignment: .trailing)
                
                Text("Quotes")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color.green"))
            }
            
            ForEach(quotes){ quotes in
                
                FlashcardSmall(front: {
                    VStack{
                        Text("Quote: " + quotes.quote)
                            .font(.system(size: 20))
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
                        Text("Author: " + quotes.author)
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
        // navigationTitle("Braking Bad Quotes")
        .onAppear(perform: {
            let url = URL(string: "https://breakingbadapi.com/api/quotes")!
            URLSession.shared.dataTask(with: url){ data, _, error in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    if let data = data{
                        let decoder = JSONDecoder()
                        do{
                            let quotes = try decoder.decode([BBQuotes].self, from: data)
                            DispatchQueue.main.async {
                                self.quotes = quotes
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

struct BBQuotes: Decodable{
    var quote_id: Int
    var quote: String
    var author: String
}

extension BBQuotes: Identifiable{
    var id: Int{
        return quote_id
    }
}
