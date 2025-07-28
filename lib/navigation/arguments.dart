// // Common Widgets
//
//
// class BottomNavArgumnets {
//   final int index;
//   BottomNavArgumnets({this.index = 0});
// }
//
// class InAppBrowserScreenArguments {
//   final String title;
//   final String link;
//   InAppBrowserScreenArguments({required this.link, required this.title});
// }
//
// // Auth Module
// class OnboardingScreenArguments {
//   final String referredBy;
//   OnboardingScreenArguments({this.referredBy = ''});
// }
//
// class LoginScreenArguments {
//   final String referredBy;
//   LoginScreenArguments({this.referredBy = ''});
// }
//
// class VerifyOtpScreenArguments {
//   final String phone;
//   final String countryCode;
//   final String referredBy;
//
//   VerifyOtpScreenArguments({
//     required this.phone,
//     required this.countryCode,
//     this.referredBy = '',
//   });
// }
//
// class CreateProfileScreenArguments {
//   final String phone;
//   final String countryCode;
//   final String referredBy;
//   CreateProfileScreenArguments(
//       {required this.phone, required this.countryCode, this.referredBy = ''});
// }
//
// //More
// class PolicyScreenArguments {
//   final String type;
//   final String title;
//   PolicyScreenArguments({required this.type, required this.title});
// }
//
// //Location
// class PickLocationScreenArguments {
//   final LatLng? coordinates;
//   PickLocationScreenArguments({
//     this.coordinates,
//   });
// }
//
// class BookingDetailScreenArguments {
//   final bool isCancelled;
//   final bool isFullyPaid;
//   final bool isCompleted;
//
//   BookingDetailScreenArguments(
//       {required this.isCancelled,
//       required this.isFullyPaid,
//       required this.isCompleted});
// }
//
// //Home module
//
// class SelectSportScreenArguments {
//   final String sportId;
//   final int selectedIndex;
//
//   SelectSportScreenArguments(
//       {required this.selectedIndex, required this.sportId});
// }
//
// class BookingScreenArguments {
//   final Venue venue;
//   final String bookingType;
//   BookingScreenArguments({
//     required this.venue,
//     required this.bookingType,
//   });
// }
//
// class SearchVenueScreenArguments {
//   final User? user;
//
//   SearchVenueScreenArguments({this.user});
// }
//
// class VenueDetailScreenArguments {
//   final String venueId;
//
//   VenueDetailScreenArguments({required this.venueId});
// }
//
// class ViewAllReviewScreenArguments {
//   final String venueId;
//
//   ViewAllReviewScreenArguments({required this.venueId});
// }
//
// // Booking Module
// class BookingSummaryScreenArguments {
//   final Venue venue;
//   final String sizeOrSport;
//   final Sport sport;
//   final String time;
//   final String hour;
//   final double amount;
//   final double taxes;
//   final DateTime bookingDate;
//   final List selectedTime;
//   final int quantity;
//   final String label;
//   final String size;
//
//   const BookingSummaryScreenArguments({
//     required this.venue,
//     required this.time,
//     required this.hour,
//     required this.sport,
//     required this.amount,
//     required this.taxes,
//     required this.selectedTime,
//     required this.bookingDate,
//     required this.sizeOrSport,
//     required this.label,
//     required this.size,
//     this.quantity = 0,
//   });
// }
//
// class ApplyCouponScreenArguments {
//   final User user;
//   final Function selectCoupon;
//   final String bookingType;
//   final Venue venue;
//
//   ApplyCouponScreenArguments({
//     required this.user,
//     required this.selectCoupon,
//     required this.bookingType,
//     required this.venue,
//   });
// }
//
// class PaymentScreenArguments {
//   final double amount;
//   final String rayzorPayId;
//   final String orderId;
//   final String bookingId;
//   final User user;
//   String couponId;
//   final bool bulkBooking;
//
//   PaymentScreenArguments({
//     required this.amount,
//     required this.rayzorPayId,
//     required this.orderId,
//     required this.bookingId,
//     required this.user,
//     required this.couponId,
//     this.bulkBooking = false,
//   });
// }
//
// class CancellationPolicyScreenArguments {
//   final String cancellationPolicy;
//   final List<CancellationCharge> cancellationCharges;
//
//   CancellationPolicyScreenArguments({
//     required this.cancellationPolicy,
//     required this.cancellationCharges,
//   });
// }

class BottomNavArgumnets {
  final int index;

  BottomNavArgumnets({this.index = 0});
}
