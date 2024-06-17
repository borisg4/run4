//
//  ContentView.swift
//  run4 Watch App
//
//  Created by Boris on 16.06.24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var count = 3
    @State private var countSetByUser = 0
    @State private var timer: Timer?
    @State private var colour = Color.gray // green = running interval
    @State private var total = 0
    @State private var timestampStart = NSDate().timeIntervalSince1970
    var body: some View {
        VStack(alignment: .center, spacing: 8){
               Text("\(count)")
                   .font(.system(size:90))
                   .fontWeight(.bold)
                   .foregroundColor(self.colour)

               HStack(alignment: .center, spacing: 8){

                   //Increment button
                   Button {
                       count = count + 1 //add 1 to the count variable each time the button is pressed
                       colour = Color.gray
                   } label: {
                       Image(systemName: "plus") //rendering an icon from SF Symbols
                           .font(.system(size:34))
                   }
                   
                   //Decrement button
                   Button {
                       count = count - 1 //subtract 1 from the count variable each time the button is pressed
                       colour = Color.gray
                   } label: {
                       Image(systemName: "minus") //rendering an icon from SF Symbols
                           .font(.system(size:34))
                   }
               }
               HStack(alignment: .center, spacing: 8){
                   Button {
                       total = 0
                       countSetByUser = count
                       colour = Color.green
                       self.runTimer()

                   }label: {
                       Text("Go!")
                           .font(.system(size:34))
                           .foregroundColor(.green)

                   }
                   Button {
                       self.stopTimer()
                   }label: {
                       Text("Stop!")
                           .font(.system(size:34))
                           .foregroundColor(.red)

                   }
               }
           }
        }
    func endOfInterval() {
        
        
        if self.colour == Color.green {
            // switch to walking interval
            self.colour = Color.yellow
            count = 1
        } else {
            // switch to running interval
            self.colour = Color.green
            count = countSetByUser
        }
        if total > 35 {
            self.stopTimer()
        } else {
            self.runTimer()
        }
     }
    func runTimer() {
        total = total + count
        //print(total)
        count = count * 60
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {time in
            if count > 0 {
                count -= 1
            }else {
              timer?.invalidate()
                count = countSetByUser
                WKInterfaceDevice.current().play(.notification)
                self.endOfInterval()
            }
        }
     }
    func stopTimer() {
        timer?.invalidate()
        colour = Color.gray
        count = countSetByUser
   }

   struct ContentView_Previews: PreviewProvider {
       static var previews: some View {
           ContentView()
       }
   }
}
