//
//  ContentView.swift
//  BreakingBadApp
//
//  Created by Computer Science on 8/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Characters: View {
    @State var characters = [BBCharacters]()
    
    
    var body: some View{
        
        ScrollView{
            
            HStack(alignment: .top, spacing: 12) {
                Image("breakingbad")
                    .resizable()
                    .frame(width: 90, height: 50, alignment: .trailing)
                
                Text("Characters")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color.green"))
            }
            
            ForEach(characters) { characters in
                Flashcard(front: {
                    VStack{
                        WebImage(url: characters.img)
                            .resizable()
                            .frame(width: 300, height: 400, alignment: .center)
                            .cornerRadius(24)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .padding(.all)
                        
                        HStack{
                            VStack(alignment: .leading, spacing: 12){
                                Text(characters.name)
                                    .font(.system(size: 30))
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
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 15)
                        .padding(.top, 25)
                    }
                }, back: {
                    VStack{
                        WebImage(url: characters.img)
                            .resizable()
                            .frame(width: 100, height: 150, alignment: .center)
                            .cornerRadius(24)
                            .scaledToFit()
                            .clipped()
                        Text("Facts about the character")
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(Color("Color.green"))
                            .frame(maxWidth: .infinity)
                            .border(Color.black)
                            .padding()
                        Text("Character name: " + characters.name)
                            .font(.system(size: 22))
                        Text("Portrayed by: " + characters.portrayed)
                            .font(.system(size: 22))
                        Text("Nickname: " + characters.nickname)
                            .font(.system(size: 22))
                        Text("Birthday: " + characters.birthday)
                            .font(.system(size: 22))
                        Text("Status: " + characters.status)
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
        
        .onAppear(perform:{
            let url = URL(string: "https://breakingbadapi.com/api/characters")!
            URLSession.shared.dataTask(with: url){ data, _, error in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    if let data = data{
                        let decoder = JSONDecoder()
                        do{
                            let characters = try decoder.decode([BBCharacters].self, from: data)
                            DispatchQueue.main.async {
                                self.characters = characters
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


struct BBCharacters: Decodable{
    
    var char_id: Int
    var name: String
    var birthday: String
    var img: URL
    var status: String
    var nickname: String
    var portrayed: String
    
}

extension BBCharacters: Identifiable{
    var id: Int{
        return char_id
    }
}

