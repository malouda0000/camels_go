import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/main.dart';
import 'package:camels_go/view/personal%20profile/model/personal_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'personal_profile_event.dart';
part 'personal_profile_state.dart';

class PersonalProfileBloc
    extends Bloc<PersonalProfileEvent, PersonalProfileState> {
  _cashUserProfileData({
    String? arabicUserName,
    String? englishUserName,
    String? userImage,
    String? userID,
    String? userNationaltyID,
    String? userNationaltyAr,
    String? userNationaltyEn,
    String? userBirthDate,
    int? userGender,
    //  String? userNationaltyID,
    String? userPhoneNumber,
    String? userEmail,
  }) {
    globalCachedArabicUserName = arabicUserName;
    globalCachedEnglishUserName = englishUserName;
    globalCachedUserImage = userImage;
    globalCachedUserID = userID;
    globalCachedNationaltyID = userNationaltyID;
    globalCachedNationaltyAr = userNationaltyAr;
    globalCachedNationaltyEn = userNationaltyEn;
    globalCachedUserEmail = userEmail;
    // cashedUserToken = token;
    globalCachedUserPhoneNum = userPhoneNumber;
    globalCachedUserBirthdate = userBirthDate;
    globalCachedUserGender = userGender;
  }

  PersonalProfileBloc() : super(PersonalProfileInitialState()) {
    on<GetPersonalProfileEvent>(_onGetPersonalProfileEvent);
  }

  Future<void> _onGetPersonalProfileEvent(
      GetPersonalProfileEvent event, Emitter<PersonalProfileState> emit) async {
    emit(PersonalProfileLoadingState());
    try {
      // Fetch data from the API using DioHelper
      final response = await DioHelper.getVendorPersonalProfile();

      // Check for successful response
      if (response.statusCode == 200) {
        final personalProfileModel =
            PersonalProfileModel.fromJson(response.data);

        _cashUserProfileData(
          arabicUserName: personalProfileModel.data?.nameAr,
          englishUserName: personalProfileModel.data?.nameEn,
          userImage: personalProfileModel.data?.image,
          // userID: personalProfileModel.data?.i
          userNationaltyID: personalProfileModel.data?.nationalityId,
          userNationaltyAr: personalProfileModel.data?.nationalityAr,
          userNationaltyEn: personalProfileModel.data?.nationalityEn,
          userBirthDate: personalProfileModel.data?.birthdate,
          userGender: personalProfileModel.data?.gender,
          //  userNationaltyID:
          userPhoneNumber: personalProfileModel.data?.mobile,
          userEmail: personalProfileModel.data?.email,
        );
        print(response.data);
        // Emit success state with the fetched data
        emit(PersonalProfileSuccessState(
            personalProfileModel: personalProfileModel));
      } else {
        emit(PersonalProfileErrorState(
            errorMessage:
                'Failed to fetch personal profile. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(PersonalProfileErrorState(errorMessage: e.toString()));
    }
  }
}
