import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/models/vehicle_type.dart';

class CurrentUserCubit extends Cubit<CurrentUser> {
  CurrentUserCubit()
      : super(CurrentUser(
          id: '',
          firstName: '',
          lastName: '',
          gender: '',
          email: '',
        ));

  void setId(String id) => emit(state.copyWith(id: id));

  void setFirstName(String firstName) =>
      emit(state.copyWith(firstName: firstName));

  void setLastName(String lastName) => emit(state.copyWith(lastName: lastName));

  void setGender(String gender) => emit(state.copyWith(gender: gender));

  void setEmail(String email) => emit(state.copyWith(email: email));

  void setProfilePic(String? profilePicURL) =>
      emit(state.copyWith(profilePicURL: profilePicURL));

  void setBio(String? bio) => emit(state.copyWith(bio: bio));

  void setOccupation(String? occupation) =>
      emit(state.copyWith(occupation: occupation));

  void setRole(String role) => emit(state.copyWith(role: role));

  void setIsVerified(bool isVerified) =>
      emit(state.copyWith(isVerified: isVerified));

  void setStars(double stars) => emit(state.copyWith(stars: stars));

  void setTotalRatings(int totalRatings) =>
      emit(state.copyWith(totalRatings: totalRatings));

  void setVehicleType(String vehicleType) => {
        if (vehicleType == null)
          {emit(state.copyWith(vehicleType: VehicleType.na))}
        else if (vehicleType == 'Bike')
          {emit(state.copyWith(vehicleType: VehicleType.bike))}
        else if (vehicleType == 'Van')
          {emit(state.copyWith(vehicleType: VehicleType.van))}
        else
          {emit(state.copyWith(vehicleType: VehicleType.car))}
      };

  void setVehicleNumber(String vehicleNumber) =>
      emit(state.copyWith(vehicleNum: vehicleNumber));
}

class CurrentUser {
  String id;
  String firstName;
  String lastName;
  String gender;
  String email;
  double stars;
  int totalRatings;
  VehicleType vehicleType;
  String vehicleNum;
  String? profilePicURL;
  String? bio;
  String? occupation;
  DateTime? dateOfBirth;
  DateTime? smsOTPSentAt;
  int? smsOTP;
  String? mobileVerified;
  bool? isVerified;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

//set defaults for constructor
  CurrentUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    this.stars = 0.0,
    this.totalRatings = 0,
    this.vehicleNum = '',
    this.vehicleType = VehicleType.na,
    this.profilePicURL,
    this.bio,
    this.occupation,
    this.dateOfBirth,
    this.smsOTP,
    this.smsOTPSentAt,
    this.mobileVerified,
    this.isVerified = false,
    this.role = 'user',
    this.createdAt,
    this.updatedAt,
  });

//for modification
  CurrentUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? gender,
    String? email,
    double? stars,
    int? totalRatings,
    VehicleType? vehicleType,
    String? vehicleNum,
    String? profilePicURL,
    String? bio,
    String? occupation,
    DateTime? dateOfBirth,
    DateTime? smsOTPSentAt,
    int? smsOTP,
    String? mobileVerified,
    bool? isVerified,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CurrentUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      stars: stars ?? this.stars,
      totalRatings: totalRatings ?? this.totalRatings,
      vehicleType: vehicleType ?? this.vehicleType,
      profilePicURL: profilePicURL ?? profilePicURL,
      vehicleNum: vehicleNum ?? this.vehicleNum,
      bio: bio ?? bio,
      occupation: occupation ?? occupation,
      dateOfBirth: dateOfBirth ?? dateOfBirth,
      smsOTP: smsOTP ?? smsOTP,
      smsOTPSentAt: smsOTPSentAt ?? smsOTPSentAt,
      mobileVerified: mobileVerified ?? mobileVerified,
      isVerified: isVerified ?? isVerified,
      createdAt: createdAt ?? createdAt,
      updatedAt: updatedAt ?? updatedAt,
    );
  }
}
