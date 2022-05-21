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
		bytes32 resumeTitle; // 이력서 제목
		bytes32 summary; // 자기소개 요약
		bytes32 motive; // 지원 동기
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

	mapping (address => bool) registered;
	address[] public registeredArray;

	// 구직자 이력서 생성
	function checkUser(address _address) public {
		if(!registered[_address]) {
			registered[_address] = true;
			registeredArray.push(_address);
		}
	}

	function add(PersonalInfo memory inf, Experience memory exp, Education memory edu, Skill memory ski) public returns (bool) {
		PersonalInfo memory info = inf;
		Experience memory expr = exp;
		Education memory educ = edu;
		Skill memory skil = ski;
		
		mResumeModels[msg.sender].personalInfos.push(info);
		mResumeModels[msg.sender].experiences.push(expr);
		mResumeModels[msg.sender].educations.push(educ);
		mResumeModels[msg.sender].skills.push(skil);

		mResumeModels[msg.sender].isNotEmpty = true;

		checkUser(msg.sender);

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
	function updateEducation(bytes32 startDate, bytes32 endDate, bytes32 institute, bytes32 degree, bytes32 faculty, bytes32 major, bytes32 gpa, uint index) public returns (bool) {
		if(mResumeModels[msg.sender].educations.length > index) {
			Education memory edu = Education(startDate, endDate, institute, degree, faculty, major, gpa, true);
			mResumeModels[msg.sender].educations[index] = edu;
			return true;
		}
		return false;
	}
	
	function updateExperience(bytes32 startDate, bytes32 endDate, bytes32 companyName, bytes32 position, uint index) public returns (bool) {
		if(mResumeModels[msg.sender].experiences.length > index) {
			Experience memory exp = Experience(startDate, endDate, companyName, position, true);
			mResumeModels[msg.sender].experiences[index] = exp;
			return true;
		}
		return false;
	}
	function updateSkill(bytes32 skill, bytes32 level, bytes32 date, uint index, bytes32 resumeTitle, bytes32 summary, bytes32 motive) public returns (bool) {
		if(mResumeModels[msg.sender].skills.length > index) {
			Skill memory skillStruct = Skill(skill, level, date, resumeTitle, summary, motive, true);
			mResumeModels[msg.sender].skills[index] = skillStruct;
			return true;
		}
		return false;
	}

	// 이력서 정보 확인
	function getPersonalInfo() external view returns (PersonalInfo[] memory) {
		return mResumeModels[msg.sender].personalInfos;
	}
	function getEducation() public view returns (Education[] memory) {
		return mResumeModels[msg.sender].educations;
	}
	function getExperience() public view returns (Experience[] memory) {
		return mResumeModels[msg.sender].experiences;
	}
	function getSkill() public view returns (Skill[] memory) {
		return mResumeModels[msg.sender].skills;
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
		return false;
	}
}