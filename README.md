# OWOer
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
