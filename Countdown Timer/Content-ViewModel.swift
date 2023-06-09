//
//  Content-ViewModel.swift
//  Countdown Timer
//
//
//


// line 12 creates the initial user interface. line 13 asssures that no other class can inherit values from this class. Line 14 determines whether the timer is in use. Line 15 determines that we are not showing an alert. Line 16 sets the display time to 15 minutes. Line 17 creates the var minutes and sets it to a float. Line 19 converts the var minutes to an integer


import Foundation
import AVFoundation


extension ContentView {   //contains the initial user interface
    final class ViewModel: ObservableObject {
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time:  String = "1:00"
        @Published var minutes: Float = 1.0 {
            
            didSet {
                self.time = "\(Int(minutes)):00"
                
            }
            
        }
        
        private var initialTime = 0     // sets the var initialTime to 0
        private  var endDate = Date()   // sets endDate to the current date
        
        //  this next func starts timer in minutes
        
        func start(minutes: Float) {   //  this starts timer in minutes
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true     // true means the timer is active
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        
        // this next func updates the var minutes to original time
        
        func reset() {
            self.minutes = Float(initialTime)
            
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        // this next func calculates the elapsed time
        
        func updateCountDown() {
            guard isActive else { return }
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {  // means timer is at zero
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
                return
                
                // coud add code here to signify time is up
            }
            // This next code allows us to grab minutes and seconds from the calendar
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.minutes = Float(minutes)
            self.time = String(format: "%d:%02d", minutes, seconds) // this creates the 2 digit display of                                                              minutes and seconds as a string
            
            
           let halftime = minutes/2  // This shoud create a float variable equal to 1/2 run time
           let chimesSoundEffect = "Chimes-sound-effect.mp3"
            
           
            
            
            
            
      /*   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  */
                        
       var player: AVAudioPlayer?

       func playSound() {
    //       guard let url = Bundle.main.url(forResource: "sound", withExtension: "mp3") else { return }
           guard let url = Bundle.main.url(forResource: chimesSoundEffect, withExtension: "mp3") else { return }
           
           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)

               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

               guard let player = player else { return }
               
               player.play()

           }
           catch let error {
               print(error.localizedDescription)
           }
     
   
           let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
           
               /* why doesn't the sound play when the halftime reached minutes/2 or when time reaches 0 */
               
               if minutes == halftime {
                
                   playSound()
                   
                   
                   if minutes == 0 {
                       timer.invalidate()
                       playSound()
                   }
                   
               }
               
           }
               
           
           
       }
                        
                    }
                }
                
            }
            
        
    
