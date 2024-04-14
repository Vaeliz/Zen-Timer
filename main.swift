import SwiftUI

struct TimerView: View {
    @State private var remainingTime = 300 // 5 minutes in seconds
    @State private var isRunning = false
    @State private var theme: TimerTheme = .nature // Default theme
    @State private var guidedSession: GuidedSession = .mindfulness // Default session type

    var body: some View {
        ZStack {
            theme.background // Use theme-specific gradient background

            VStack {
                Text("Zen Timer Pro")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Circle()
                    .trim(from: 0, to: CGFloat(remainingTime) / 300)
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

enum GuidedSession {
    case mindfulness, lovingKindness, bodyScan
   
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
