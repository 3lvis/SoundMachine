import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("Window not found") }

        window.rootViewController = Controller()
        window.makeKeyAndVisible()

        return true
    }
}

extension UIView {
    class func instanceFromNib<T: UIView>(bundle: Bundle = .main) -> T {
        return UINib(nibName: String(describing: T.self), bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }

    public func fillSuperview(with insets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = self.superview else { return }

        let constants = [
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            ]

        constants.forEach { constant in
            constant.priority = UILayoutPriority(rawValue: 999)
            constant.isActive = true
        }
    }
}
