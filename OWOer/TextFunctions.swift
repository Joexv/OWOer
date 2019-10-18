//
//  TextFunctions.swift
//  OWOer
//
//  Created by Joe Oliveira on 7/8/19.
//  Copyright © 2019 Alternative Apps Unlimited. All rights reserved.
//

import Foundation

class owo{
    let z = zalgo()
    let defaults = UserDefaults.standard
    let group = UserDefaults.init(suiteName: "group.OWO")
    
    func SpongeBoB(_ Text: String) -> String{
        if(!getGroup("capsRandom")){
            let result = Text.enumerated()
                .map { $0.offset % 2 == 0 ? String($0.element).uppercased() : String($0.element) }
                .joined()
            return result
        }else{
            let result = Text.map {
                if Int.random(in: 0...1) == 0 {
                    return String($0).lowercased()}
                return String($0).uppercased()
                }.joined(separator: "")
            return  result
        }
    }
    
    func OWO(_ Text: String, _ UWU:[String:String]) -> String{
        var results: String = Text
        for text in UWU.keys{
            results = results.replacingOccurrences(of: text, with: UWU[text]!)
        }
        return results
    }
    
    func OWO_Alt(_ text: String, _ UWU:[String:String]) -> String{
        var results: String = ""
        for char in text{
            results = results + (UWU[String(char)] ?? String(char))
        }
        return results
    }
    
    func doZalgo(_ Text: String, _ Intensity: Int) -> String{
        let mediumZalgos = z.zalgos(intensity: Intensity)
        let Zalgoify = z.zalgoify(with: mediumZalgos)
        return Zalgoify(Text).run()
    }
    
    func Clap(_ Text: String) -> String{
        var Results: String = Text
        if(getGroup("iGotTheClaps")){
            Results = Text.uppercased()
        }
        Results = Results.replacingOccurrences(of: "\n", with: "👏\n👏")
        return Results.replacingOccurrences(of: " ", with: "👏")
    }
    
    func getGroup(_ forKey: String) -> Bool{
        return group?.bool(forKey: forKey) ?? false
    }
    
    let yeOld: [String] = ["-th", "-ist", "-st", ""]
    
    let yeOlder:[String : String] = ["you" : "thou", "You" : "Ye", "over there" : "over yander", "old" : "eald", "Old" : "Eald", "brother" : "brodor", "house" : "hus", "net":"nett", "right":"riht", "Right":"Riht", "wife":"wif", "woman":"wifmann", "girl":"wench", "boy":"lad", "go quickly":"hie", "no":"nay", "teacher":"schoolman", "poison":"bane", "maid":"tweeny", "confused":"jargogled", "confuse":"jargogle", "enojyed":"deliciated", "lol":"kench", "violence":"sanguinolency", "tipsy":"bibesy"]
    
    func yeMold(_ Text: String) -> String{
        var results: String = Text
        for text in yeOlder.keys{
            results = results.replacingOccurrences(of: text, with: yeOlder[text]!)
        }
        var arr: [String] = results.split{$0 == " "}.map(String.init)
        if(getGroup("oldPrefix")){
            for n in 0...arr.count - 1{
                let gen = Int(arc4random_uniform(UInt32(yeOld.count)))
                arr[n] = arr[n] + yeOld[gen]
            }
        }
        return arr.joined(separator: " ")
    }
    
    //Credits to Nepeta for inspiring this and for her UWU text things
    let uwu: [String : String] = [
        "r": "w",
        "l": "w",
        "R": "W",
        "L": "W",
        "ow": "OwO",
        "no": "nu",
        "has": "haz",
        "have": "haz",
        "you": "uu",
        "the ": "da ",
    ]
    let fancy: [String: String] = [
        "a" : "𝒶",
        "b" : "𝒷",
        "c" : "𝒸",
        "d" : "𝒹",
        "e" : "𝑒",
        "f" : "𝒻",
        "g" : "𝑔",
        "h" : "𝒽",
        "i" : "𝒾",
        "j" : "𝒿",
        "k" : "𝓀",
        "l" : "𝓁",
        "m" : "𝓂",
        "n" : "𝓃",
        "o" : "𝑜",
        "p" : "𝓅",
        "q" : "𝓆",
        "r" : "𝓇",
        "s" : "𝓈",
        "t" : "𝓉",
        "u" : "𝓊",
        "v" : "𝓋",
        "w" : "𝓌",
        "x" : "𝓍",
        "y" : "𝓎",
        "z" : "𝓏",
        "A" : "𝒜",
        "B" : "𝐵",
        "C" : "𝒞",
        "D" : "𝒟",
        "E" : "𝐸",
        "F" : "𝐹",
        "G" : "𝒢",
        "H" : "𝐻",
        "I" : "𝐼",
        "J" : "𝒥",
        "K" : "𝒦",
        "L" : "𝐿",
        "M" : "𝑀",
        "N" : "𝒩",
        "O" : "𝒪",
        "P" : "𝒫",
        "Q" : "𝒬",
        "R" : "𝑅",
        "S" : "𝒮",
        "T" : "𝒯",
        "U" : "𝒰",
        "V" : "𝒱",
        "W" : "𝒲",
        "X" : "𝒳",
        "Y" : "𝒴",
        "Z" : "𝒵"
    ]
    
    let Fraktur: [String: String] = [
        "a" : "𝔞",
        "b" : "𝔟",
        "c" : "𝔠",
        "d" : "𝔡",
        "e" : "𝔢",
        "f" : "𝔣",
        "g" : "𝔤",
        "h" : "𝔥",
        "i" : "𝔦",
        "j" : "𝔧",
        "k" : "𝔨",
        "l" : "𝔩",
        "m" : "𝔪",
        "n" : "𝔫",
        "o" : "𝔬",
        "p" : "𝔭",
        "q" : "𝔮",
        "r" : "𝔯",
        "s" : "𝔰",
        "t" : "𝔱",
        "u" : "𝔲",
        "v" : "𝔳",
        "w" : "𝔴",
        "x" : "𝔵",
        "y" : "𝔶",
        "z" : "𝔷",
        "A" : "𝔄",
        "B" : "𝔅",
        "C" : "ℭ",
        "D" : "𝔇",
        "E" : "𝔈",
        "F" : "𝔉",
        "G" : "𝔊",
        "H" : "ℌ",
        "I" : "ℑ",
        "J" : "𝔍",
        "K" : "𝔎",
        "L" : "𝔏",
        "M" : "𝔐",
        "N" : "𝔑",
        "O" : "𝔒",
        "P" : "𝔓",
        "Q" : "𝔔",
        "R" : "ℜ",
        "S" : "𝔖",
        "T" : "𝔗",
        "U" : "𝔘",
        "V" : "𝔙",
        "W" : "𝔚",
        "X" : "𝔛",
        "Y" : "𝔜",
        "Z" : "ℨ"
    ]
    
    let upsideDown: [String: String] = [
        "\u{0021}" : "\u{00A1}",
    "\u{0022}" : "\u{201E}",
    "\u{0026}" : "\u{214B}",
    "\u{0027}" : "\u{002C}",
    "\u{0028}" : "\u{0029}",
    "\u{002E}" : "\u{02D9}",
    "\u{0033}" : "\u{0190}",
    "\u{0034}" : "\u{152D}",
    "\u{0036}" : "\u{0039}",
    "\u{0037}" : "\u{2C62}",
    "\u{003B}" : "\u{061B}",
    "\u{003C}" : "\u{003E}",
    "\u{003F}" : "\u{00BF}",
    "\u{0041}" : "\u{2200}",
    "\u{0042}" : "\u{10412}",
    "\u{0043}" : "\u{2183}",
    "\u{0044}" : "\u{25D6}",
    "\u{0045}" : "\u{018E}",
    "\u{0046}" : "\u{2132}",
    "\u{0047}" : "\u{2141}",
    "\u{004A}" : "\u{017F}",
    "\u{004B}" : "\u{22CA}",
    "\u{004C}" : "\u{2142}",
    "\u{004D}" : "\u{0057}",
    "\u{004E}" : "\u{1D0E}",
    "\u{0050}" : "\u{0500}",
    "\u{0051}" : "\u{038C}",
    "\u{0052}" : "\u{1D1A}",
    "\u{0054}" : "\u{22A5}",
    "\u{0055}" : "\u{2229}",
    "\u{0056}" : "\u{1D27}",
    "\u{0059}" : "\u{2144}",
    "\u{005B}" : "\u{005D}",
    "\u{005F}" : "\u{203E}",
    "\u{0061}" : "\u{0250}",
    "\u{0062}" : "\u{0071}",
    "\u{0063}" : "\u{0254}",
    "\u{0064}" : "\u{0070}",
    "\u{0065}" : "\u{01DD}",
    "\u{0066}" : "\u{025F}",
    "\u{0067}" : "\u{0183}",
    "\u{0068}" : "\u{0265}",
    "\u{0069}" : "\u{0131}",
    "\u{006A}" : "\u{027E}",
    "\u{006B}" : "\u{029E}",
    "\u{006C}" : "\u{0283}",
    "\u{006D}" : "\u{026F}",
    "\u{006E}" : "\u{0075}",
    "\u{0072}" : "\u{0279}",
    "\u{0074}" : "\u{0287}",
    "\u{0076}" : "\u{028C}",
    "\u{0077}" : "\u{028D}",
    "\u{0079}" : "\u{028E}",
    "\u{007B}" : "\u{007D}",
    "\u{203F}" : "\u{2040}",
    "\u{2045}" : "\u{2046}",
    "\u{2234}" : "\u{2235}",
    "W":"M", //Stupid unicode list I got didn't have a capital W, the fuck?
    "u":"n",
    "p":"d"
    ]

    let bubbles: [String:String] = [
    "A":"🅐",
    "B":"🅑",
    "C":"🅒",
    "D":"🅓",
    "E":"🅔",
    "F":"🅕",
    "G":"🅖",
    "H":"🅗",
    "I":"🅘",
    "J":"🅙",
    "K":"🅚",
    "L":"🅛",
    "M":"🅜",
    "N":"🅝",
    "O":"🅞",
    "P":"🅟",
    "Q":"🅠",
    "R":"🅡",
    "S":"🅢",
    "T":"🅣",
    "U":"🅤",
    "V":"🅥",
    "W":"🅦",
    "X":"🅧",
    "Y":"🅨",
    "Z":"🅩",]
}

struct Gen<A> {
    let run: () -> A
}

extension Gen {
    func map<B>(_ f: @escaping (A) -> B) -> Gen<B> {
        return .init { f(self.run()) }
    }
    
    func array(count: Gen<Int>) -> Gen<[A]> {
        return .init {
            Array(repeating: (), count: count.run())
                .map { self.run() }
        }
    }
}

class zalgo{
    func int(in range: ClosedRange<Int>) -> Gen<Int> {
        return .init { Int.random(in: range) }
    }
    
    func zalgos(intensity: Int) -> Gen<String> {
        return int(in: 0x300 ... 0x36f).map { String(UnicodeScalar($0)!) }.array(count: int(in: 0...intensity)).map { $0.joined() }
    }
    
    func zalgoify(with zalgos: Gen<String>) -> (String) -> Gen<String> {
        return { string in
            return Gen {
                string
                    .map { char in String(char) + zalgos.run() }
                    .joined()
            }
        }
    }
}

