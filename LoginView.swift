import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var authService: AuthService

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "film.fill")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundStyle(AppColors.primaryRed)
                    Text("MovieMatch")
                        .font(.largeTitle).bold()
                        .foregroundStyle(AppColors.onBackground)
                    Text("Swipe to pick the perfect movie with friends")
                        .font(.subheadline)
                        .foregroundStyle(AppColors.muted)
                }
                .multilineTextAlignment(.center)
                .padding(.top, 40)

                Button(action: { authService.signInMock() }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.primaryRed)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LoginView().environmentObject(AuthService())
}
