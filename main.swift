import SwiftUI

struct TimerView: View {
    @State private var remainingTime = 300 // 5 minutes in seconds
    @State private var isRunning = false
    @State private var theme: TimerTheme = .nature // Default theme
    
    // Add the GuidedSession enum state variable
    @State private var guidedSession: GuidedSession = .mindfulness // Default session type

    // Add the isMusicOn boolean state variable
    @State private var isMusicOn = false

    var body: some View {
        ZStack {
            theme.background // Use theme-specific gradient background

            VStack {
                Text("Zen Timer Pro")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    
                // Add the Picker view here
                Picker("Select Session", selection: $guidedSession) {
                    ForEach(GuidedSession.allCases, id: \.self) { session in
                        Text(session.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Circle()
                    .trim(from: 0, to: CGFloat(remainingTime) / 300)
                    .stroke(Color.white, lineWidth: 10)
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                    .scaleEffect(isRunning ? 1.2 : 1.0) // Adjust the scale factor as needed
                    .animation(.easeInOut(duration: 5)) // Customize the animation duration
                
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
                
                // Add the Button view here
                Button(action: {
                    isMusicOn.toggle()
                    // Play or pause background music here
                }) {
                    Image(systemName: isMusicOn ? "speaker.wave.2.fill" : "speaker.slash.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isRunning {
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    // Timer completed
                    // Play selected chime sound
                    // Save session history
                    isRunning = false
                }
            }
        }
    }
}

enum TimerTheme {
    case nature, cosmic, minimal

    var background: LinearGradient {
        switch self {
        case .nature:
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
        case .cosmic:
            return LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .top, endPoint: .bottom)
        case .minimal:
            return LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
        }
    }
}

enum GuidedSession: String {
    case mindfulness = "Mindfulness"
    case lovingKindness = "Loving Kindness"
    case bodyScan = "Body Scan"
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
