//
//  ViewController.swift
//  Implementing Error Handling in Swift 4
//
//  Created by Matthew Harrilal on 9/14/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let network1 = Network()
        print(network1.networking())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct Pokemon {
    let name: String
    let height:Int
    let weight:Int
    init(name:String, height:Int,weight:Int) {
        self.name = name
        self.height = height
        self.weight = weight
    }
    // So essentially what we are doing here is that we are modeling the data becuase when we get back the JSON file of all the data from the pokemon file that we get back we get all this extra stuff that we will not need therefore what we are doing here is that we are modeling that data to give us back only the stuff that we want, that is why we declare the variables that we want
    
    // And then from here we are essentially initalizing the new instances by giving each instance a name, height, weight and this prepares the instances that are going to come out of this class
}
extension Pokemon: Decodable {
    enum Keys: String, CodingKey {
        case name
        case height
        case weight
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        let height: Int = try container.decode(Int.self, forKey: .height)
        let weight:Int = try container.decode(Int.self, forKey: .weight)
        self.init(name: name, height: height, weight: weight)
    }
    
}

class Network {
    func networking() {
        let session = URLSession.shared
        let getRequest = URLRequest(url: URL(string: "http://pokeapi.co/api/v2/pokemon/36/")!)
        
        session.dataTask(with: getRequest) { (data, response, error) in
            
            if let data = data {
                guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
        
                else{return}
                print(pokemon.name)
                print(pokemon.weight)
                print(pokemon.height)
            }
        }.resume()
    }
  
    
}

