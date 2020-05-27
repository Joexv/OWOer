# OWOer
Ever wondered how people make those cool comments or posts on your favorite non descriptive social media sites?

Ever wanted to be able to make that same text without having to go to some sketchy website?

Well now you can!

Introducing the OWOer. It can OwOify your messages, it can make you get your point across with some classic clapping emojis. It can solve world hunger.

Okay well maybe not that last thing, but you get the idea.

With more styles being worked on and added, you will be able to convert your text into just about anything you could ever dream of!

Featuring a simple easy to use UI for both the main app, a keyboard, and the additional iMessage extension, you can be sure that even if you've never asked 'uwu what's this?' before, you will be able to do it a thousand times with no problems!
Disclaimer: Don't ask that a thousand times. Ask it two thousand times. Up those numbers ya degenerate.

#Why
A simple text changer for IOS 10+
Inspired by Nepeta's UWU tweak, that will change how notifications look.
But instead of notifications, this allows you to write in different text styles without a Jailbreak

Most fuctions are stored in the file TextFunctions.swift
Both the main application and iMessage application use this class for converting text, 
but use their own class for button functions and the like

If you are testing and want to try out the iMessage extension without dealing with sandbox purchasing,
add the following lines to a button or viewDidAppear
    group?.setBool(true, "Unlocked")
    defaults.setBool(true, "Ad_Removal")
