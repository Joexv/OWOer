//
//  TextFunctions.swift
//  OWOer
//
//  Created by Joe Oliveira on 7/8/19.
//  Copyright © 2019 Alternative Apps Unlimited. All rights reserved.
//

import Foundation

class owo{
    let styleArray: [String] = ["Plain", "Double Stack 𝕒𝕓𝕔", "Flipped ɐqɔ", "Gothic 𝔞𝔟𝔠", "Fancy 𝒶𝒷𝒸", "Bubbles 🅐🅑🅒", "Squares 🅰🅱🅲", "Zalgo", "Fancy Bold 𝓪𝓫𝓬", "Russian Style ДБC", "Asian Style 1 ﾑ乃ᄃ", "Alien ꍏꌃꉓ", "Neon ᗩᗷᑕ", "Squiggle ค๒ς", "Asian Style 2 卂乃匚", "Sign Language 👍👎👊"]
    let optionsArray: [String] = ["None", "cApS", "👏", "UwU", "Mega UwU", "Ye Olde", "Hearts $♥", "White Bracket『$』", "Black Bracket【$】", "Emojifier"]
    
    func fontChanger(_ Selection: Int, _ ToChange: String, Zalgo: Int = 0) -> String{
        var Text: String = ToChange
        switch Selection{
            case 1:
                Text = OWO(Text, doubleStack)
            case 2:
                Text = OWO(Text, upsideDown)
                Text = String(Array(Text).reversed())
            case 3:
                Text = OWO(Text, Fraktur)
            case 4:
                Text = OWO(Text, fancy)
            case 5:
                Text = OWO(Text, bubbles)
            case 6:
                Text = OWO(Text, square)
            case 7:
                if(!(group?.bool(forKey: "zalgoAlways") ?? false)){
                   Text = doZalgo(Text, Zalgo)
                }else{
                    break
            }
            case 8:
                Text = OWO(Text, fancyBold)
            case 9:
                Text = OWO(Text, totallyRussian)
            case 10:
                Text = OWO(Text, totallyKanji)
            case 11:
                Text = OWO(Text, alien)
            case 12:
                Text = OWO(Text, neon)
            case 13:
                Text = OWO(Text, squiggle)
            case 14:
                Text = OWO(Text, totallyMandarin)
            case 15:
                Text = OWO(Text, signLanguage)
            default:
                break;
        }
        
        if(Zalgo > 0 && group?.bool(forKey: "zalgoAlways") ?? false){
            Text = doZalgo(Text, Zalgo)
        }
        
        return Text
    }
    
    func textAdjustment(_ Selection: Int, _ ToChange: String) -> String{
        var Text: String = ToChange
        switch Selection{
            case 1:
                Text = SpongeBoB(Text)
            case 2:
                Text = Clap(Text)
            case 3:
                Text = OWO(Text, uwu)
            case 4:
                Text = Mega_OWO(Text)
            case 5:
                Text = yeMold(Text)
            case 6:
                if(group?.bool(forKey: "hearts") ?? false){
                    Text = Clap(Text, "♥")
                }else{
                    Text = specialCharacter(Text, hearts)
                }
            case 7:
                Text = specialCharacter(Text, wBracket)
            case 8:
                Text = specialCharacter(Text, bBracket)
            case 9:
                Text = eM.GenEmojiPasta(Text)
                NSLog("Oh God what have I done?")
            default:
                NSLog("No Change")
        }
        return Text
    }

    let eM = EmojiMap_Mod()
    let z = zalgo()
    let defaults = UserDefaults.standard
    let group = UserDefaults.init(suiteName: "group.OWO")
    
    //👍👎👊✊🤛🤜🤞✌️🤟🤘👌🤏👈👉👆👇☝️✋🤚🖐🖖👋🤙🤲👐🙌👍👎👊✊🤛🤜🤞✌️🤟🤘👌🤏👈👉👆👇☝️✋🤚🖐🖖👋🤙🤲👐🙌
    let signLanguage: [String:String] = ["a":"👍", "b":"👎", "c":"👊", "d":"✊", "e":"🤛", "f":"🤜", "g":"🤞", "h":"✌️", "i":"🤟", "j":"🤘", "k":"👌", "l":"🤏", "m":"👈", "n":"👉", "o":"👆", "p":"👇", "q":"☝️", "r":"✋", "s":"🤚", "t":"🖐", "u":"🖖", "v":"👋", "w":"🤙", "x":"🤲", "y":"👐", "z":"🙌", "A":"👍", "B":"👎", "C":"👊", "D":"✊", "E":"🤛", "F":"🤜", "G":"🤞", "H":"✌️", "I":"🤟", "J":"🤘", "K":"👌", "L":"🤏", "M":"👈", "N":"👉", "O":"👆", "P":"👇", "Q":"☝️", "R":"✋", "S":"🤚", "T":"🖐", "U":"🖖", "V":"👋", "W":"🤙", "X":"🤲", "Y":"👐", "Z":"🙌"]
    
    //卂乃匚ᗪ乇千Ꮆ卄丨ﾌҜㄥ爪几ㄖ卩Ɋ尺丂ㄒㄩᐯ山乂ㄚ乙卂乃匚ᗪ乇千Ꮆ卄丨ﾌҜㄥ爪几ㄖ卩Ɋ尺丂ㄒㄩᐯ山乂ㄚ乙
    let totallyMandarin: [String:String] = ["a":"卂", "b":"乃", "c":"匚", "d":"ᗪ", "e":"乇", "f":"千", "g":"Ꮆ", "h":"卄", "i":"丨", "j":"ﾌ", "k":"Ҝ", "l":"ㄥ", "m":"爪", "n":"几", "o":"ㄖ", "p":"卩", "q":"Ɋ", "r":"尺", "s":"丂", "t":"ㄒ", "u":"ㄩ", "v":"ᐯ", "w":"山", "x":"乂", "y":"ㄚ", "z":"乙", "A":"卂", "B":"乃", "C":"匚", "D":"ᗪ", "E":"乇", "F":"千", "G":"Ꮆ", "H":"卄", "I":"丨", "J":"ﾌ", "K":"Ҝ", "L":"ㄥ", "M":"爪", "N":"几", "O":"ㄖ", "P":"卩", "Q":"Ɋ", "R":"尺", "S":"丂", "T":"ㄒ", "U":"ㄩ", "V":"ᐯ", "W":"山", "X":"乂", "Y":"ㄚ", "Z":"乙"]
    
    //ค๒ς๔єŦﻮђเןкɭ๓ภ๏קợгรՇยשฬאץչค๒ς๔єŦﻮђเןкɭ๓ภ๏קợгรՇยשฬאץչ
    let squiggle: [String:String] = ["a":"ค", "b":"๒", "c":"ς", "d":"๔", "e":"є", "f":"Ŧ", "g":"ﻮ", "h":"ђ", "i":"เ", "j":"ן", "k":"к", "l":"ɭ", "m":"๓", "n":"ภ", "o":"๏", "p":"ק", "q":"ợ", "r":"г", "s":"ร", "t":"Շ", "u":"ย", "v":"ש", "w":"ฬ", "x":"א", "y":"ץ", "z":"չ", "A":"ค", "B":"๒", "C":"ς", "D":"๔", "E":"є", "F":"Ŧ", "G":"ﻮ", "H":"ђ", "I":"เ", "J":"ן", "K":"к", "L":"ɭ", "M":"๓", "N":"ภ", "O":"๏", "P":"ק", "Q":"ợ", "R":"г", "S":"ร", "T":"Շ", "U":"ย", "V":"ש", "W":"ฬ", "X":"א", "Y":"ץ", "Z":"չ"]
    
    //ᗩᗷᑕᗪEᖴGᕼIᒍKᒪᗰᑎOᑭᑫᖇᔕTᑌᐯᗯ᙭YᘔᗩᗷᑕᗪEᖴGᕼIᒍKᒪᗰᑎOᑭᑫᖇᔕTᑌᐯᗯ᙭Yᘔ
    let neon: [String:String] = ["a":"ᗩ", "b":"ᗷ", "c":"ᑕ", "d":"ᗪ", "e":"E", "f":"ᖴ", "g":"G", "h":"ᕼ", "i":"I", "j":"ᒍ", "k":"K", "l":"ᒪ", "m":"ᗰ", "n":"ᑎ", "o":"O", "p":"ᑭ", "q":"ᑫ", "r":"ᖇ", "s":"ᔕ", "t":"T", "u":"ᑌ", "v":"ᐯ", "w":"ᗯ", "x":"᙭", "y":"Y", "z":"ᘔ", "A":"ᗩ", "B":"ᗷ", "C":"ᑕ", "D":"ᗪ", "E":"E", "F":"ᖴ", "G":"G", "H":"ᕼ", "I":"I", "J":"ᒍ", "K":"K", "L":"ᒪ", "M":"ᗰ", "N":"ᑎ", "O":"O", "P":"ᑭ", "Q":"ᑫ", "R":"ᖇ", "S":"ᔕ", "T":"T", "U":"ᑌ", "V":"ᐯ", "W":"ᗯ", "X":"᙭", "Y":"Y", "Z":"ᘔ", ]
    
    //𝓪𝓫𝓬𝓭𝓮𝓯𝓰𝓱𝓲𝓳𝓴𝓵𝓶𝓷𝓸𝓹𝓺𝓻𝓼𝓽𝓾𝓿𝔀𝔁𝔂𝔃𝓐𝓑𝓒𝓓𝓔𝓕𝓖𝓗𝓘𝓙𝓚𝓛𝓜𝓝𝓞𝓟𝓠𝓡𝓢𝓣𝓤𝓥𝓦𝓧𝓨𝓩
    let fancyBold: [String:String] = ["a" : "𝓪", "b" : "𝓫", "c" : "𝓬", "d" : "𝓭", "e" : "𝓮", "f" : "𝓯", "g" : "𝓰", "h" : "𝓱", "i" : "𝓲", "j" : "𝓳", "k" : "𝓴", "l" : "𝓵", "m" : "𝓶", "n" : "𝓷", "o" : "𝓸", "p" : "𝓹", "q" : "𝓺", "r" : "𝓻", "s" : "𝓼", "t" : "𝓽", "u" : "𝓾", "v" : "𝓿", "w" : "𝔀", "x" : "𝔁", "y" : "𝔂", "z" : "𝔃", "A" : "𝓐", "B" : "𝓑", "C" : "𝓒", "D" : "𝓓", "E" : "𝓔", "F" : "𝓕", "G" : "𝓖", "H" : "𝓗", "I" : "𝓘", "J" : "𝓙", "K" : "𝓚", "L" : "𝓛", "M" : "𝓜", "N" : "𝓝", "O" : "𝓞", "P" : "𝓟", "Q" : "𝓠", "R" : "𝓡", "S" : "𝓢", "T" : "𝓣", "U" : "𝓤", "V" : "𝓥", "W" : "𝓦", "X" : "𝓧", "Y" : "𝓨", "Z" : "𝓩"]
    //ꍏꌃꉓꀸꍟꎇꁅꃅꀤꀭꀘ꒒ꂵꈤꂦꉣꆰꋪꌗ꓄ꀎꃴꅏꊼꌩꁴꍏꌃꉓꀸꍟꎇꁅꃅꀤꀭꀘ꒒ꂵꈤꂦꉣꆰꋪꌗ꓄ꀎꃴꅏꊼꌩꁴ
    let alien: [String:String] = ["a":"ꍏ", "b":"ꌃ", "c":"ꉓ", "d":"ꀸ", "e":"ꍟ", "f":"ꎇ", "g":"ꁅ", "h":"ꃅ", "i":"ꀤ", "j":"ꀭ", "k":"ꀘ", "l":"꒒", "m":"ꂵ", "n":"ꈤ", "o":"ꂦ", "p":"ꉣ", "q":"ꆰ", "r":"ꋪ", "s":"ꌗ", "t":"꓄", "u":"ꀎ", "v":"ꃴ", "w":"ꅏ", "x":"ꊼ", "y":"ꌩ", "z":"ꁴ", "A":"ꍏ", "B":"ꌃ", "C":"ꉓ", "D":"ꀸ", "E":"ꍟ", "F":"ꎇ", "G":"ꁅ", "H":"ꃅ", "I":"ꀤ", "J":"ꀭ", "K":"ꀘ", "L":"꒒", "M":"ꂵ", "N":"ꈤ", "O":"ꂦ", "P":"ꉣ", "Q":"ꆰ", "R":"ꋪ", "S":"ꌗ", "T":"꓄", "U":"ꀎ", "V":"ꃴ", "W":"ꅏ", "X":"ꊼ", "Y":"ꌩ", "Z":"ꁴ"]
    
    //ДБCDΞFGHIJҜLMИФPǪЯSΓЦVЩЖУZДБCDΞFGHIJҜLMИФPǪЯSΓЦVЩЖУZ
    let totallyRussian: [String:String] = ["a" : "Д", "b" : "Б", "c" : "C", "d" : "D", "e" : "Ξ", "f" : "F", "g" : "G", "h" : "H", "i" : "I", "j" : "J", "k" : "Ҝ", "l" : "L", "m" : "M", "n" : "И", "o" : "Ф", "p" : "P", "q" : "Ǫ", "r" : "Я", "s" : "S", "t" : "Γ", "u" : "Ц", "v" : "V", "w" : "Щ", "x" : "Ж", "y" : "У", "z" : "Z", "A" : "Д", "B" : "Б", "C" : "C", "D" : "D", "E" : "Ξ", "F" : "F", "G" : "G", "H" : "H", "I" : "I", "J" : "J", "K" : "Ҝ", "L" : "L", "M" : "M", "N" : "И", "O" : "Ф", "P" : "P", "Q" : "Ǫ", "R" : "Я", "S" : "S", "T" : "Γ", "U" : "Ц", "V" : "V", "W" : "Щ", "X" : "Ж", "Y" : "У", "Z" : "Z"]
    
    //🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉
    let square: [String:String] = ["a":"🅰", "b":"🅱", "c":"🅲", "d":"🅳", "e":"🅴", "f":"🅵", "g":"🅶", "h":"🅷", "i":"🅸", "j":"🅹", "k":"🅺", "l":"🅻", "m":"🅼", "n":"🅽", "o":"🅾", "p":"🅿", "q":"🆀", "r":"🆁", "s":"🆂", "t":"🆃", "u":"🆄", "v":"🆅", "w":"🆆", "x":"🆇", "y":"🆈", "z":"🆉", "A":"🅰", "B":"🅱", "C":"🅲", "D":"🅳", "E":"🅴", "F":"🅵", "G":"🅶", "H":"🅷", "I":"🅸", "J":"🅹", "K":"🅺", "L":"🅻", "M":"🅼", "N":"🅽", "O":"🅾", "P":"🅿", "Q":"🆀", "R":"🆁", "S":"🆂", "T":"🆃", "U":"🆄", "V":"🆅", "W":"🆆", "X":"🆇", "Y":"🆈", "Z":"🆉"]
    
    //ﾑ乃ᄃり乇ｷムんﾉﾌズﾚﾶ刀のｱゐ尺丂ｲひ√Wﾒﾘ乙ﾑ乃ᄃり乇ｷムんﾉﾌズﾚﾶ刀のｱゐ尺丂ｲひ√Wﾒﾘ乙
    let totallyKanji: [String:String] = ["a":"ﾑ", "b":"乃", "c":"ᄃ", "d":"り", "e":"乇", "f":"ｷ", "g":"ム", "h":"ん", "i":"ﾉ", "j":"ﾌ", "k":"ズ", "l":"ﾚ", "m":"ﾶ", "n":"刀", "o":"の", "p":"ｱ", "q":"ゐ", "r":"尺", "s":"丂", "t":"ｲ", "u":"ひ", "v":"√", "w":"W", "x":"ﾒ", "y":"ﾘ", "z":"乙", "A":"ﾑ", "B":"乃", "C":"ᄃ", "D":"り", "E":"乇", "F":"ｷ", "G":"ム", "H":"ん", "I":"ﾉ", "J":"ﾌ", "K":"ズ", "L":"ﾚ", "M":"ﾶ", "N":"刀", "O":"の", "P":"ｱ", "Q":"ゐ", "R":"尺", "S":"丂", "T":"ｲ", "U":"ひ", "V":"√", "W":"W", "X":"ﾒ", "Y":"ﾘ", "Z":"乙"]
    
    let hearts: String = "$♥"
    let bBracket: String = "【$】"
    let wBracket: String = "『$』"
    
    func specialCharacter(_ Text: String, _ Adjustment: String, WhitespaceOnly: Bool = false) -> String{
        var results: String = ""
        for char in Text{
            if(WhitespaceOnly && char.isWhitespace){
                results = results + Adjustment.replacingOccurrences(of: "$", with: String(char))
            }else if(!char.isWhitespace && char != " "){
                results = results + Adjustment.replacingOccurrences(of: "$", with: String(char))
            }
        }
        
        return results
    }
    
    let mOWO: [String] = [" *nuzzles* ", " *pounces* ", "", " uwu ", " owo ", " :3 ", " ^^; "]
    func Mega_OWO(_ Text: String) -> String{
        var results: String = Text
        for text in uwu.keys{
            results = results.replacingOccurrences(of: text, with: uwu[text]!)
        }
        
        var count: Int = 0
        for char in results{
            let insert: String = mOWO.randomElement()!
            if(char == " "){
                results.insert(contentsOf: insert, at: results[count])
                count += insert.count
            }
            count += 1
        }
        return results
    }
    
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
    
    func Clap(_ Text: String, _ Replacement: String = "👏") -> String{
        var Results: String = Text
        if(getGroup("iGotTheClaps") && Replacement == "👏"){
            Results = Text.uppercased()
        }
        Results = Results.replacingOccurrences(of: "\n", with: "\(Replacement)\n")
        return Results.replacingOccurrences(of: " ", with: "\(Replacement)")
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
    
    let doubleStack: [String: String] = [
        "a" : "𝕒",
        "b" : "𝕓",
        "c" : "𝕔",
        "d" : "𝕕",
        "e" : "𝕖",
        "f" : "𝕗",
        "g" : "𝕘",
        "h" : "𝕙",
        "i" : "𝕚",
        "j" : "𝕛",
        "k" : "𝕜",
        "l" : "𝕝",
        "m" : "𝕞",
        "n" : "𝕟",
        "o" : "𝕠",
        "p" : "𝕡",
        "q" : "𝕢",
        "r" : "𝕣",
        "s" : "𝕤",
        "t" : "𝕥",
        "u" : "𝕦",
        "v" : "𝕧",
        "w" : "𝕨",
        "x" : "𝕩",
        "y" : "𝕪",
        "z" : "𝕫",
        "A" : "𝔸",
        "B" : "𝔹",
        "C" : "ℂ",
        "D" : "𝔻",
        "E" : "𝔼",
        "F" : "𝔽",
        "G" : "𝔾",
        "H" : "ℍ",
        "I" : "𝕀",
        "J" : "𝕁",
        "K" : "𝕂",
        "L" : "𝕃",
        "M" : "𝕄",
        "N" : "ℕ",
        "O" : "𝕆",
        "P" : "ℙ",
        "Q" : "ℚ",
        "R" : "ℝ",
        "S" : "𝕊",
        "T" : "𝕋",
        "U" : "𝕌",
        "V" : "𝕍",
        "W" : "𝕎",
        "X" : "𝕏",
        "Y" : "𝕐",
        "Z" : "ℤ",
    ]
    
    let fancy: [String: String] = [
        " " : "  ",
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
        "Z" : "𝒵",
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

    let bubbles: [String:String] = ["a":"🅐", "b":"🅑", "c":"🅒", "d":"🅓", "e":"🅔", "f":"🅕", "g":"🅖", "h":"🅗", "i":"🅘", "j":"🅙", "k":"🅚", "l":"🅛", "m":"🅜", "n":"🅝", "o":"🅞", "p":"🅟", "q":"🅠", "r":"🅡", "s":"🅢", "t":"🅣", "u":"🅤", "v":"🅥", "w":"🅦", "x":"🅧", "y":"🅨", "z":"🅩", "A":"🅐", "B":"🅑", "C":"🅒", "D":"🅓", "E":"🅔", "F":"🅕", "G":"🅖", "H":"🅗", "I":"🅘", "J":"🅙", "K":"🅚", "L":"🅛", "M":"🅜", "N":"🅝", "O":"🅞", "P":"🅟", "Q":"🅠", "R":"🅡", "S":"🅢", "T":"🅣", "U":"🅤", "V":"🅥", "W":"🅦", "X":"🅧", "Y":"🅨", "Z":"🅩"]
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

extension String {
    subscript (index: Int) -> String.Index {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return charIndex
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }

}

extension String {
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
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

