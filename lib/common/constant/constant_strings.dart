/// Centralized strings with grouped sections for easier discovery and maintenance.
/// Note: Existing ConstantStrings.* names are preserved for backward compatibility
/// by forwarding to grouped sections below (no breaking changes).
class ConstantStrings {
  // App
  static const String appName = AppStrings.appName;
  static const String appDescriptionTitle = AppStrings.appDescriptionTitle;
  static const String appDescriptionBody = AppStrings.appDescriptionBody;
  static const String appDescriptionSubBody = AppStrings.appDescriptionSubBody;
  static const String appVersion = AppStrings.appVersion;
  static const String appTagline = AppStrings.appTagline;
  static const String welcomeMessage = AppStrings.welcomeMessage;
  static const String homeTitle = AppStrings.homeTitle;
  static const String settingsTitle = AppStrings.settingsTitle;
  static const String profileTitle = AppStrings.profileTitle;

  // Buttons / CTAs
  static const String loginButton = AuthStrings.loginButton;
  static const String signUpButton = AuthStrings.signUpButton;
  static const String logoutButton = AuthStrings.logoutButton;
  static const String continueWithGoogle = AuthStrings.continueWithGoogle;

  // Assets
  static const String registerationLogo = AssetPaths.registerationLogo;
  static const String googleLogo = AssetPaths.googleLogo;
  static const String appTextLogo = AssetPaths.appTextLogo;

  // Auth feedback
  static const String loginSuccess = AuthStrings.loginSuccess;
  static const String loginFailed = AuthStrings.loginFailed;
  static const String signupSuccess = AuthStrings.signupSuccess;
  static const String signupFailed = AuthStrings.signupFailed;
  static const String logoutSuccess = AuthStrings.logoutSuccess;
  static const String logoutInProgress = AuthStrings.logoutInProgress;
  static const String deletingAccount = AuthStrings.deletingAccount;
  static const String logoutFailed = AuthStrings.logoutFailed;
  static const String invalidCredentials = AuthStrings.invalidCredentials;
  static const String authenticating = AuthStrings.authenticating;
  static const String delete = AuthStrings.delete;
  static const String deleteFailed = AuthStrings.deleteFailed;

  // Legal
  static const String userAgreement = LegalStrings.userAgreement;
  static const String userAgreementDescription =
      LegalStrings.userAgreementDescription;
  static const String andString = LegalStrings.andString;
  static const String privacyPolicy = LegalStrings.privacyPolicy;

  // Profile
  static const String connectWithUs = ProfileStrings.connectWithUs;
  static const String facebook = ProfileStrings.facebook;
  static const String joinOurCommunity = ProfileStrings.joinOurCommunity;
  static const String instagram = ProfileStrings.instagram;
  static const String followUsOnInstagram = ProfileStrings.followUsOnInstagram;
  static const String rateUs = ProfileStrings.rateUs;
  static const String helpUsImprove = ProfileStrings.helpUsImprove;
  static const String learnMoreAboutUs = ProfileStrings.learnMoreAboutUs;
  static const String aboutUs = ProfileStrings.aboutUs;
  static const String appVersionString = ProfileStrings.appVersionString;
  static const String yourAds = ProfileStrings.yourAds;
  static const String manageYourAds = ProfileStrings.manageYourAds;
  static const String favourites = ProfileStrings.favourites;
  static const String yourSavedItems = ProfileStrings.yourSavedItems;
  static const String termsAndConditions = ProfileStrings.termsAndConditions;
  static const String legalInformation = ProfileStrings.legalInformation;
  static const String protectingYourPrivacy =
      ProfileStrings.protectingYourPrivacy;
  static const String checkForUpdates = ProfileStrings.checkForUpdates;
  static const String keepYourAppUpdated = ProfileStrings.keepYourAppUpdated;
  static const String deleteAccount = ProfileStrings.deleteAccount;
  static const String permanentlyDeleteAccount =
      ProfileStrings.permanentlyDeleteAccount;
  static const String aboutUsDescription = ProfileStrings.aboutUsDescription;
  static const String termsAndConditionsDescription =
      ProfileStrings.termsAndConditionsDescription;
  static const String privacyPolicyDescription =
      LegalStrings.privacyPolicyDescription;

  // dashboard tab strings
  static const String bikesTab = DashboardStrings.bikesTab;
  static const String searchTab = DashboardStrings.searchTab;
  static const String chatTab = DashboardStrings.chatTab;
  static const String profileTab = DashboardStrings.profileTab;

  // Tooltips
  static const String backButtonTooltip = TooltipStrings.backButtonTooltip;
  static const String creatPostTooltip = TooltipStrings.creatPostTooltip;

  // post
  static const String postCreateSuccess = PostStrings.postCreateSuccess;
  static const String postCreateFailed = PostStrings.postCreateFailed;
  static const String createPostForAds = PostStrings.createPostForAds;
  static const String fillInDetails = PostStrings.fillInDetails;
  static const String uploadImages = PostStrings.uploadImages;
}

// -------- Grouped sections --------

//  post
class PostStrings {
  static const String postCreateSuccess = "Post created successfully!";
  static const String postCreateFailed =
      "Failed to create post. Please try again.";
  static const String createPostForAds = "Create post for Ads";
  static const String fillInDetails =
      'Fill in the details to create your post all are required';
  static const String uploadImages = "Upload some images of your vehicle";
}

// Tooltips
class TooltipStrings {
  static const String backButtonTooltip = "Back";
  static const String creatPostTooltip = "Create Post";
}

// app related strings
class AppStrings {
  static const String appName = "HamroBike";
  static const String appDescriptionTitle = "Hey there 👋";
  static const String appDescriptionBody = "\nBuy or sell bikes with ease.";
  static const String appDescriptionSubBody =
      "\nDiscover your next ride on HamroBike.";
  static const String appVersion = "1.0.0";
  static const String appTagline = "Buy. Sell. Ride.";
  static const String welcomeMessage = "Welcome to MyFlutterApp!";
  static const String homeTitle = "Home";
  static const String settingsTitle = "Settings";
  static const String profileTitle = "Profile";
}

class AssetPaths {
  static const String registerationLogo = "assets/registration.png";
  static const String googleLogo = "assets/google_logo.png";
  static const String appTextLogo = "assets/app_name_logo.png";
}

class AuthStrings {
  // Buttons / CTAs
  static const String loginButton = "Log In";
  static const String signUpButton = "Sign Up";
  static const String logoutButton = "Log Out";
  static const String continueWithGoogle = "Continue with Google";

  // Feedback
  static const String loginSuccess = "Login Successful!";
  static const String loginFailed = "Login Failed. Please try again.";
  static const String signupSuccess = "Signup Successful!";
  static const String signupFailed = "Signup Failed. Please try again.";
  static const String logoutSuccess = "Logout Successful!";
  static const String logoutInProgress = "Logging out";
  static const String deletingAccount = "Deleting account";
  static const String logoutFailed = "Logout Failed. Please try again.";
  static const String invalidCredentials =
      "Invalid credentials. Please check and try again.";
  static const String authenticating = "Authenticating";
  static const String delete = 'Account deleted successfully!';
  static const String deleteFailed =
      "Account deletion failed. Please try again.";
}

class LegalStrings {
  static const String userAgreement = "User Agreement";
  static const String andString = " and ";
  static const String privacyPolicy = "Privacy Policy";
  static const String privacyPolicyDescription = '''🔒 Privacy Policy

\n1. Information We Collect:

. Basic profile information (name, email, profile picture) via Google Sign-In.

. User activity like posts, favorites, and chats.

. Device and location info (for showing nearby listings).

2. How We Use Your Data:

. To show relevant listings and improve user experience.

. To prevent fraud and ensure platform safety.

. To contact you about important updates or support.

3. Data Sharing:

. We do not sell or rent user data.

. Data may be shared with trusted third-party services (Firebase, analytics, ads) strictly to operate the app.

4. Data Security:

. We use Firebase Authentication and Firestore with strict access controls.

. However, no online system is 100% secure — use the app responsibly.

5. User Control:

. You may delete your account anytime, and your data will be removed as per our policy.

6. Updates:

. Privacy Policy may change occasionally; the latest version will always be shown inside the app.''';
  static const String userAgreementDescription = '''📜 User Agreement

\nWelcome to HamroBike!
By using our app, you agree to the following terms and conditions. Please read them carefully before using the service.

1. Acceptance:
By accessing or using HamroBike, you agree to comply with these terms. If you do not agree, please do not use the app.

2. Eligibility:
You must be at least 18 years old to post, buy, or sell bikes and scooters through this platform.

3. User Responsibility:
HamroBike is a platform only — we do not own or verify the bikes listed. All transactions are made directly between buyers and sellers.
Users are responsible for verifying ownership, condition, and authenticity before completing a transaction.

4. Prohibited Activities:

. Posting fake, misleading, or stolen vehicle listings.

. Using HamroBike for illegal activities or scams.

. Sharing offensive or fraudulent content.

5. Account:
You are responsible for maintaining your account credentials and ensuring all information provided is true and accurate.

6. Liability:
HamroBike does not guarantee the quality, legality, or performance of any listed item or transaction.

7. Changes:
We may update these terms from time to time. Continued use of the app means you accept the latest version.''';
}

class ProfileStrings {
  static const String connectWithUs = "Connect with us";
  static const String facebook = "Facebook Group";
  static const String joinOurCommunity = "Join our community";
  static const String instagram = "Instagram";
  static const String followUsOnInstagram = "Follow us on Instagram";
  static const String rateUs = "Rate Us";
  static const String helpUsImprove = "Help us improve";
  static const String learnMoreAboutUs = "Learn more about us";
  static const String aboutUs = "About Us";
  static const String aboutUsDescription = '''🏍️ About Us

\nHamroBike is a Nepali startup project created to make buying and selling used bikes and scooters simple, safe, and community-driven.

We believe every rider should have an easy way to find their next ride or sell their old one — without dealing with cluttered listings or scams.

Built with love in Nepal 🇳🇵 using Flutter & Firebase, HamroBike aims to become the most trusted two-wheeler marketplace in the country.

Our mission:

To connect Nepali riders through a trusted and easy-to-use platform for trading two-wheelers.

Our vision:

To build Nepal’s most reliable and user-friendly bike marketplace.''';

  static const String appVersionString = "Version :1.0.0";
  static const String yourAds = "Your Ads";
  static const String manageYourAds = "Manage your ads";
  static const String favourites = "Favourites";
  static const String yourSavedItems = "Your saved items";
  static const String termsAndConditions = "Terms and Conditions";
  static const String termsAndConditionsDescription = '''⚖️ Terms and Conditions

\n1. Purpose:
HamroBike provides a marketplace for users to buy and sell second-hand two-wheelers (bikes and scooters).

2. Listing Rules:

. Sellers must provide accurate details and real images.

. Listings must represent the actual vehicle for sale.

. Once a deal is complete, sellers must mark the item as Sold.

3. Communication:
Users can chat within the app or contact each other directly. HamroBike is not responsible for any conversation or offline transaction.

4. Fees:
Currently, HamroBike is free to use. However, premium or featured listing options may be added later.

5. Termination:
We reserve the right to suspend or delete accounts that violate our policies.''';
  static const String legalInformation = "Legal Information";
  static const String protectingYourPrivacy = "How we protect your data";
  static const String checkForUpdates = "Check for Updates";
  static const String keepYourAppUpdated = "Keep your app updated";
  static const String deleteAccount = "Delete Account";
  static const String permanentlyDeleteAccount = "Permanently delete account";
}

class DashboardStrings {
  static const String bikesTab = "Bikes";
  static const String searchTab = "Search";
  static const String chatTab = "Chats";
  static const String profileTab = "Profile";
}
