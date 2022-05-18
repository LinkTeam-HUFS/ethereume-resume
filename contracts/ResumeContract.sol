// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "./Ownable.sol";

contract ResumeContract is Ownable {

	// Constructor
	constructor() {}

	// 개인 정보
	struct PersonalInfo {
		bytes32 picUrl; // 증명사진
		bytes32 name; // 이름
		bytes32 phone; // 생년월일
		bytes32 email; // 이메일
		bytes32 dateOfBirth; // 생년월일
		bytes32 socialUrl; // 블로그 주소, 깃헙저장소 등등 소셜 Url
		bytes32 location; // 주소
	}

	// 학력 및 경력 정보
	struct Education {
		bytes32 eduStartDate; // 입학 날짜
		bytes32 eduEndDate; // 졸업 날짜
		bytes32 institute; // 교육 기관명
		bytes32 degree; // 학위
		bytes32 faculty; // 학부
		bytes32 major; // 전공
		bytes32 gpa; // 학점
		bool isNotEmpty;
	}

	struct Experience {
		bytes32 expStartDate; // 입사 날짜
		bytes32 expEndDate; // 퇴사 날짜
		bytes32 companyName; // 회사명
		bytes32 position; // 직위
		bool isNotEmpty;
	}

	// 자격증 및 수상 경력 정보
	struct Skill {
		bytes32 skillName; // 자격증명, 수상명
		bytes32 level; // 취득 자격 종류, 수상 종류
		bytes32 date; // 취득 일자
		bool isNotEmpty;
	}


	struct ResumeModel {
		PersonalInfo[] personalInfos;
		Experience[] experiences;
		Education[] educations;
		Skill[] skills;
		bool isNotEmpty;
	}

	mapping (address => ResumeModel) mResumeModels;
	mapping(address => uint) registerd;
	address[] public registeredArray;
	uint public resumeCount = 0;
	function getUsers() public view returns (address[] memory){
		return registeredArray;
	}

	// 구직자 이력서 생성
	function addPersonalInfo(bytes32 picUrl, bytes32 name, bytes32 phone, bytes32 email, bytes32 dateOfBirth, bytes32 socialUrl, bytes32 location) public returns (bool) {
		PersonalInfo memory info = PersonalInfo(picUrl, name, phone, email, dateOfBirth, socialUrl, location);
		mResumeModels[msg.sender].personalInfos.push(info);
		mResumeModels[msg.sender].isNotEmpty = true;
		return true;
	}
	function addEducation(bytes32 startDate, bytes32 endDate, bytes32 institute, bytes32 degree, bytes32 faculty, bytes32 major, bytes32 gpa) public returns (bool) {
		Education memory edu = Education(startDate, endDate, institute, degree, faculty, major, gpa, true);
		mResumeModels[msg.sender].educations.push(edu);
		mResumeModels[msg.sender].isNotEmpty = true;
		return true;
	}
	function addExperience(bytes32 startDate, bytes32 endDate, bytes32 companyName, bytes32 position) public returns (bool) {
		Experience memory exp = Experience(startDate, endDate, companyName, position, true);
		mResumeModels[msg.sender].experiences.push(exp);
		mResumeModels[msg.sender].isNotEmpty = true;
		return true;
	}
	function addSkill(bytes32 skill, bytes32 level, bytes32 date) public returns (bool) {
		Skill memory skillStruct = Skill(skill, level, date, true);
		mResumeModels[msg.sender].skills.push(skillStruct);
		mResumeModels[msg.sender].isNotEmpty = true;
    	if(registerd[msg.sender] != 1) {
        	registerd[msg.sender] = 1;
        	registeredArray.push(msg.sender); // push to the array
		}
		resumeCount++;
		return true;
	}

	// 구직자 이력서 수정
	function updatePersonalInfo(bytes32 picUrl, bytes32 name, bytes32 phone, bytes32 email, bytes32 dateOfBirth, bytes32 socialUrl, bytes32 location, uint index) public returns (bool) {
		if(mResumeModels[msg.sender].personalInfos.length > index) {
			PersonalInfo memory info = PersonalInfo(picUrl, name, phone, email, dateOfBirth, socialUrl, location);
			mResumeModels[msg.sender].personalInfos[index] = info;
		
			return true;
		}
		return false;
	}
	function updateEducation(bytes32 eduStartDate, bytes32 eduEndDate, bytes32 institute, bytes32 degree, bytes32 faculty, bytes32 major, bytes32 gpa, uint index) public returns (bool) {
		if(mResumeModels[msg.sender].personalInfos.length > index) {			
			Education memory edu = Education(eduStartDate, eduEndDate, institute, degree, faculty, major, gpa, true);
			mResumeModels[msg.sender].educations[index] = edu;		
			return true;
		}
		return false;
	}
	function updateExperience(bytes32 expStartDate, bytes32 expEndDate, bytes32 companyName, bytes32 position, uint index) public returns (bool) {
		if(mResumeModels[msg.sender].personalInfos.length > index) {
			Experience memory exp = Experience(expStartDate, expEndDate, companyName, position, true);
			mResumeModels[msg.sender].experiences[index] = exp;			
		
			return true;
		}
		return false;
	}
	function updateSkill(bytes32 skill, bytes32 level, bytes32 date, uint index) public returns (bool) {
		if(mResumeModels[msg.sender].personalInfos.length > index) {			
			Skill memory skillStruct = Skill(skill, level, date, true);
			mResumeModels[msg.sender].skills[index] = skillStruct;
		
			return true;
		}
		return false;
	}

	// 이력서 정보 확인
	function getPersonalInfo() external view returns(PersonalInfo[] memory) {
		return mResumeModels[msg.sender].personalInfos;
	}

	function getEducation() public view returns (Education[] memory) {
		return mResumeModels[msg.sender].educations;
	}

	function getExperience() public view returns (Experience[] memory) {
		return  mResumeModels[msg.sender].experiences;
	}

	function getSkill() public view returns (Skill[] memory) {
		return  mResumeModels[msg.sender].skills;
	}
	// 이력서 전체 불러오기
	function getAllPersonalInfo()  external view returns (PersonalInfo[][] memory) {
		PersonalInfo[][] memory allPersonalInfos;
		for(uint i = 0; i < registeredArray.length; i++) {
			allPersonalInfos[i] = mResumeModels[registeredArray[i]].personalInfos;
		}
		return allPersonalInfos;
	}
	function getAllEducation()  external view returns (Education[][] memory) {
		Education[][] memory allEducations;
		for(uint i = 0; i < registeredArray.length; i++) {
			allEducations[i] = mResumeModels[registeredArray[i]].educations;
		}
		return allEducations;
	}
	function getAllExperience()  external view returns (Experience[][] memory) {
		Experience[][] memory allExperiences;
		for(uint i = 0; i < registeredArray.length; i++) {
			allExperiences[i] = mResumeModels[registeredArray[i]].experiences;
		}
		return allExperiences;
	}
	function getAllSkill()  external view returns (Skill[][] memory) {
		Skill[][] memory allSkills;
		for(uint i = 0; i < registeredArray.length; i++) {
			allSkills[i] = mResumeModels[registeredArray[i]].skills;
		}
		return allSkills;
	}

	// 구직자 이력서 삭제
	function remove(uint index) public returns (bool) {
		if(mResumeModels[msg.sender].personalInfos.length > index) {
			for(uint i = index; i < mResumeModels[msg.sender].personalInfos.length-1; i++) {
				mResumeModels[msg.sender].personalInfos[i] = mResumeModels[msg.sender].personalInfos[i+1];
				mResumeModels[msg.sender].educations[i] = mResumeModels[msg.sender].educations[i+1];
				mResumeModels[msg.sender].experiences[i] = mResumeModels[msg.sender].experiences[i+1];
				mResumeModels[msg.sender].skills[i] = mResumeModels[msg.sender].skills[i+1];
			}
			mResumeModels[msg.sender].personalInfos.pop();
			mResumeModels[msg.sender].educations.pop();
			mResumeModels[msg.sender].experiences.pop();
			mResumeModels[msg.sender].skills.pop();
	
			return true;	
		}
		resumeCount--;
		return false;
	}

	event personalInfoEvent(bytes32 picUrl, bytes32 name, bytes32 phone, bytes32 email, bytes32 dateOfBirth, bytes32 socialUrl, bytes32 location);

	event educationEvent(bytes32 eduStartDate, bytes32 eduEndDate, bytes32 institute, bytes32 degree, bytes32 faculty, bytes32 major, bytes32 gpa, uint count, uint index);
		 
	event experienceEvent(bytes32 expStartDate, bytes32 expEndDate, bytes32 companyName, bytes32 position, uint count, uint index);

	event skillEvent(bytes32 skillName, bytes32 level, bytes32 date, uint count, uint index);

	event resumeEmptyEvent();


	function triggerGetResumeByEvent(address accountId) public {
		if(mResumeModels[accountId].isNotEmpty){
			triggerGetPersonalInfoByEvent(accountId);
			triggerGetExperienceByEvent(accountId);
			triggerGetEducationByEvent(accountId);
			triggerGetSkillByEvent(accountId);
		}else{
			emit resumeEmptyEvent();
		}
	}

	function triggerGetPersonalInfoByEvent(address accountId) public {
		if(mResumeModels[accountId].isNotEmpty) {
			PersonalInfo[] memory info;
			info = mResumeModels[accountId].personalInfos;

			for(uint i=0; i < info.length; i++) {
				PersonalInfo memory inf = info[i];
				emit personalInfoEvent(inf.picUrl, inf.name, inf.phone, inf.email, inf.dateOfBirth, inf.socialUrl, inf.location);
			}
		}
	}

	function triggerGetEducationByEvent(address accountId) public {
		if(mResumeModels[accountId].isNotEmpty) {
			Education[] memory eduList;
			eduList = mResumeModels[accountId].educations;

			for(uint i=0; i < eduList.length; i++) {
				Education memory edu = eduList[i];
				emit educationEvent(edu.eduStartDate, edu.eduEndDate, edu.institute, edu.degree, edu.faculty, edu.major, edu.gpa, eduList.length, i);
			}
		}
	}
	
	function triggerGetExperienceByEvent(address accountId) public {
		if(mResumeModels[accountId].isNotEmpty) {
			Experience[] memory expList;
			expList = mResumeModels[accountId].experiences;

			for(uint i=0; i < expList.length; i++) {
				Experience memory exp = expList[i];
				emit experienceEvent(exp.expStartDate, exp.expEndDate, exp.companyName, exp.position, expList.length, i);
			}
		}
	}

	function triggerGetSkillByEvent(address accountId) public {
		if(mResumeModels[accountId].isNotEmpty) {
			Skill[] memory skillList;
			skillList = mResumeModels[accountId].skills;

			for(uint i=0; i < skillList.length; i++) {
				Skill memory skill = skillList[i];
				emit skillEvent(skill.skillName, skill.level, skill.date, skillList.length, i);
			}
		}
	}
}