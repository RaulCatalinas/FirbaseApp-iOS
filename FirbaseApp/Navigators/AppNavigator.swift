import UIKit

final class AppNavigator {

    static func showHome() {
        let storyboard = Storyboard.home.instance

        guard
            let homeVC = storyboard.instantiateViewController(
                withIdentifier: StoryboardID.mainViewController.rawValue
            ) as? MainViewController
        else {
            assertionFailure(
                "MainViewController misconfigured in HomeScreen.storyboard"
            )
            return
        }

        switchRoot(to: homeVC)
    }

    static func showAuth() {
        guard
            let authVC = Storyboard.main.instance
                .instantiateInitialViewController()
        else {
            assertionFailure("Main.storyboard has no initial view controller")
            return
        }

        switchRoot(to: authVC)
    }

    // MARK: - Private Helpers

    private static func switchRoot(to viewController: UIViewController) {
        guard let window = keyWindow else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    private static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
