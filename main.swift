import SwiftUI

struct TimerView: View {
    @State private var remainingTime = 300 // 5 minutes in seconds
    @State private var isRunning = false

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Zen Timer")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Circle()
                    .trim(from: 0, to: CGFloat(remainingTime) / 300) // Adjust for your desired duration
                    .stroke(Color.white, lineWidth: 10)
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))

                Text("\(remainingTime / 60):\(remainingTime % 60, specifier: "%02d")")
                    .font(.title)
                    .foregroundColor(.white)

                Button(action: {
                    isRunning.toggle()
                }) {
                    Text(isRunning ? "Pause" : "Start")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
            }
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isRunning {
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    // Timer completed
                    // Play chime sound
                    // Save session history
                    isRunning = false
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
