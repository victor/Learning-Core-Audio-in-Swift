//
//  main.swift
//  CAMetadata
//
//  Created by Victor Jalencas on 11/06/14.
//  Copyright (c) 2014 Hand Forged Apps. All rights reserved.
//

import Foundation
import AudioToolbox
import Darwin




if (C_ARGC < 2) {
    println("Usage: CAMetadata /full/path/to/audiofile")
    exit(-1)
}


var audioFilePath : CFString = NSString.stringWithCString(C_ARGV[1], encoding:NSUTF8StringEncoding).stringByExpandingTildeInPath as NSString


var audioURL: CFURL = CFURLCreateWithString(kCFAllocatorDefault, audioFilePath, nil)
var audioFile: AudioFileID = nil
var theErr: OSStatus? = nil

let hint: AudioFileTypeID = 0

theErr = AudioFileOpenURL(audioURL, Int8(kAudioFileReadPermission), hint, &audioFile)

assert(theErr == OSStatus(noErr),  "theErr is not 0")

var outDataSize: UInt32 = 0
var isWritable: UInt32 = 0
theErr = AudioFileGetPropertyInfo(audioFile, UInt32(kAudioFilePropertyInfoDictionary), &outDataSize, &isWritable)
assert(theErr == OSStatus(noErr),  "theErr is not 0")

var dictionary: CFDictionary? = nil
// also: var dictionary: NSDictionary = NSDictionary.init()
// also var dictionary: CMutableVoidPointer = nil

theErr = AudioFileGetProperty(audioFile, UInt32(kAudioFilePropertyInfoDictionary), &outDataSize, &dictionary)
assert(theErr == OSStatus(noErr))

println("Dictionary: \(dictionary)")

exit(0)
