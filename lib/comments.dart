// GetBuilder<AddFriendController>(
// init: addFriendController,
// builder: (controller) {
// return Visibility(
// visible: controller.getFriendRequestList.isNotEmpty,
// child: Column(
// children: [
// // Header Row with "REQUESTS" and optional "SEE ALL"
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "REQUESTS",
// style: MyTextTheme.greyNormal,
// ),
// // Show "SEE ALL" only if requests are more than 2
// Visibility(
// visible: controller.getFriendRequestList.length > 2,
// child: InkWell(
// onTap: () {
// Get.to(
// () => SeeAll(),
// transition: Transition.rightToLeft,
// duration: const Duration(milliseconds: 500),
// curve: Curves.ease,
// );
// },
// child: Text(
// "SEE ALL",
// style: MyTextTheme.greyNormal,
// ),
// ),
// ),
// ],
// ),
// const SizedBox(height: 5),
// // Show ListView if request count <= 2, otherwise show only first 2 in this list
// ListView.builder(
// shrinkWrap: true,
// itemCount: controller.getFriendRequestList.length <= 2
// ? controller.getFriendRequestList.length
//     : 2, // Show only first 2 if there are more than 2 requests
// itemBuilder: (context, index) {
// FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
//
// return Row(
// children: [
// // Profile Picture
// Container(
// width: 35,
// height: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// image: friendRequestData.picture != null &&
// friendRequestData.picture!.isNotEmpty
// ? DecorationImage(
// image: NetworkImage(
// "http://182.156.200.177:8011${friendRequestData.picture}"),
// fit: BoxFit.cover,
// )
//     : null,
// color: friendRequestData.picture == null ||
// friendRequestData.picture!.isEmpty
// ? AppColor.circleIndicator
//     : null,
// ),
// child: friendRequestData.picture == null ||
// friendRequestData.picture!.isEmpty
// ? const Icon(Icons.person,
// size: 20, color: Colors.white)
//     : null,
// ),
//
// // User Details
// Expanded(
// child: Padding(
// padding: const EdgeInsets.only(left: 12.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// friendRequestData.name.toString(),
// style: MyTextTheme.mediumGCB.copyWith(
// fontSize: 16,
// color: Colors.black,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ),
// ),
// // Accept and Decline Buttons
// Row(
// children: [
// InkWell(
// onTap: () async {
// await controller.acceptFriendRequest(
// friendRequestData);
// await notificationController
//     .readNotificationMessage(
// notificationController.notifications[index]
// ['id']
//     .toString());
// await dashBoardController.pending.value
//     .toString();
// },
// child: Container(
// height: MediaQuery.of(context).size.height * 0.04,
// width: MediaQuery.of(context).size.width * 0.2,
// decoration: BoxDecoration(
// border: Border.all(color: AppColor.white),
// borderRadius: BorderRadius.circular(10),
// color: AppColor.circleIndicator,
// ),
// child: const Center(
// child: Text(
// "Accept",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),
// const SizedBox(width: 5),
// InkWell(
// onTap: () async {
// await controller.declineRequest(friendRequestData);
// controller.friendRequestList.removeAt(index);
// controller.update();
// },
// child: Container(
// height: MediaQuery.of(context).size.height * 0.04,
// width: MediaQuery.of(context).size.width * 0.2,
// decoration: BoxDecoration(
// border: Border.all(color: AppColor.white),
// borderRadius: BorderRadius.circular(10),
// color: AppColor.greyColor,
// ),
// child: const Center(
// child: Text(
// "Decline",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),
// ],
// ),
// ],
// );
// },
// ),
// ],
// ),
// );
// },
// ),