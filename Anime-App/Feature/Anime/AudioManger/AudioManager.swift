//
//  AudioManager.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 27/08/2023.
//

import Foundation
import AVFoundation

class AudioManager {
    
    private var player: AVAudioPlayer?
    
    func play(name: String) {
        stop()
        guard let path = Bundle.main.path(forResource: name, ofType:"m4a") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        player?.stop()
    }
}
