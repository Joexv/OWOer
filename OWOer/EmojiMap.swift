//
//  EmojiMap.swift
//  EmojiMap
//
//  Created by Matias Villaverde on 17.11.17.
//
//

import Foundation

// Mapping of the regular text to emoji characters
public typealias WordToEmojiMapping = [String : [String]]
/// `Match` class keeps information about a single word that can be replaced with an emoji.
public struct Match {
    
    public let string: String
    public let emoji: String
    
    public init(string: String, emoji: String) {
        self.string = string
        self.emoji = emoji
    }
}


/// Tool to get the possible match from a word to an emoji.
open class EmojiMap_Mod {
    public init() {}
    
    /// Database of emojis in the user language
    lazy var mapping = self.defaultTextToEmojiMapping()
    
    public func GenEmojiPasta(_ text: String) -> String{
        print("Generating Emojified text")
        let blocks: [String] = text.components(separatedBy: " ")
        var newBlocks: [String] = []
        
        for item in blocks{
            let word = (item.alphanumeric).lowercased()
            if let matches = mapping[word] {
                var Emojis: String = ""
                for _ in 0...(arc4random_uniform(3)){
                    let rndInt = Int(arc4random_uniform(UInt32(matches.count - 1)))
                    let match = Match(string: word, emoji: matches[rndInt])
                    Emojis += "\(match.emoji)"
                }
                newBlocks.append(item + Emojis)
            }else{
                newBlocks.append(item)
            }
        }
        return newBlocks.joined(separator: " ")
    }
    
    /// Get the match of all the emojis that can represent words of the input string
    ///
    /// - Parameter inputString: String in EN, DE, FR or ES
    /// - Returns: array of Matches that contains the emoji and the word
    public func getMatchesFor(_ inputString: String) -> [Match] {
        
        // Output array.
        var outPut = [Match]()
        
        // Separe the string in words.
        for word in inputString.lowercased().components(separatedBy: " ") {
            
            // Get match searching on emoji db
            if let matches = mapping[word] {
                for mapped in matches {
                    let match = Match(string: word, emoji: mapped)
                    outPut.append(match)
                }
            }
        }
        
        // Return output
        return outPut
    }
    
    /// Get a random match from all the emojis that can represent words of the input string
    ///
    /// - Parameter inputString: String in EN, DE, FR or ES
    /// - Returns: array of Matches that contains the emoji and the word
    public func getSingleRandomMatchesFor(_ inputString: String) -> [Match] {
        
        // Output array.
        var outPut = [Match]()
        
        // Separe the string in words.
        for word in inputString.lowercased().components(separatedBy: " ") {
            
            // Get a random match searching on emoji db
            if let matches = mapping[word] {
                let rndInt = Int(arc4random_uniform(UInt32(matches.count - 1)))
                let match = Match(string: word, emoji: matches[rndInt])
                outPut.append(match)
            }
        }
        
        // Return random output
        return outPut
        
    }
    
    /// Search for the emoji db in the current language of the user. Currently supported only EN, DE, FR and ES
    ///
    /// - Returns: Mapping of the regular text to emoji characters
    public func defaultTextToEmojiMapping() -> WordToEmojiMapping {
        
        var mapping: WordToEmojiMapping = [:]
        
        func addKey(_ key: String, value: String, atBeginning: Bool) {
            
            if mapping[key] == nil {
                mapping[key] = []
            }
            
            if atBeginning {
                mapping[key]?.insert(value, at: 0)
            } else {
                mapping[key]?.append(value)
            }
        }
        
        // Order the json in a dictionary
        for (key, value) in emojiDataBase() {
            if let key = key as? String,
                let dictionary = value as? Dictionary<String, AnyObject>,
                let emojiCharacter = dictionary["char"] as? String {
                
                // Dictionary keys from emojis.json have higher priority then keywords.
                // That's why they're added at the beginning of the array.
                addKey(key, value: emojiCharacter, atBeginning: true)
                
                // Keywords have a lower priority than dictionary keys, are added at the end.
                if let keywords = dictionary["keywords"] as? [String] {
                    for keyword in keywords {
                        addKey(keyword.lowercased(), value: emojiCharacter, atBeginning: false)
                    }
                }
            }
        }
        
        return mapping
    }
    
    //TODO make this not so ugly
    func emojiDataBase() -> NSDictionary {
        print("Getting Emoji DB")
        let groupFile = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.owo")?.appendingPathComponent("emojis-Downloaded.json")
        let dlFile = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("emojis-Downloaded.json")
        
        if let path = groupFile?.path {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonDictionary = json as! NSDictionary
                print("Using AppGroup JSON")
                return jsonDictionary
            } catch let error {
                print("AppGroup parse error: \(error.localizedDescription)")
            }
        }else if FileManager().fileExists(atPath: dlFile.path) {
            do {
                let data = try Data(contentsOf: dlFile, options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonDictionary = json as! NSDictionary
                print("Using Documents JSON")
                return jsonDictionary
            } catch let error {
                print("Documents parse error: \(error.localizedDescription)")
            }
        }else if let path = Bundle.main.path(forResource: "emojis-OWO", ofType: "json") {
            do {
                print("Using Main Bundle JSON")
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonDictionary = json as! NSDictionary
                return jsonDictionary
            } catch let error {
                print("Main Bundle parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
            
        }
        
        return [:]
    }
}

