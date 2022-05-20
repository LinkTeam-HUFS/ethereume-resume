<template>
  <!--아이콘 및 폰트 연결-->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
    rel="stylesheet"
  />
  <link
    href="https://fonts.googleapis.com/icon?family=Material+Icons"
    rel="stylesheet"
  />

  <!--메뉴 바 구현-->
  <div>
    <ul>
      <li>
        <a href=""></a>
      </li>

    </ul>

    <div class="menu">
      <label for="expand-menu"><div>메뉴</div></label>
      <input type="checkbox" id="expand-menu" name="expand-menu" />
      <ul>
        <li>
          <a href="#" class="item"><div>회사 프로필</div></a>
        </li>
        <li>
          <a href="#" class="item"><div>채용 공고 수정</div></a>
        </li>
        <li>
          <a href="#" class="item"><div>채용한 지원자들</div></a>
        </li>
        <li>
          <a href="#" class="item"><div>찜한 지원자들</div></a>
        </li>
            <router-link to='/'>구직자 페이지</router-link>
        <li>
        </li>
      </ul>
    </div>
  </div>

  <!------------------------------------------------------------------>
  <!--내가 찜한 지원자들 구현 -->
  <div class="background" v-if="isResumeOpen == true">
    <div class="modal">
      <div>
        <button class="close" @click="resumeClosed">닫기</button>
        <!-- <div>
          <h2>인적사항</h2>
          <br />
          <h2>학력사항</h2>
          <br />
          <h2>경력사항</h2>
          <br />
          <h2>자격증 및 수상 경력</h2>
          <br />
          <button @click="updateResume">이력서 수정</button>
        </div> -->
      </div>
    </div>
  </div>

  <!--메인페이지-->
  <div style="overflow: auto" class="main-all">
    <section class="skewdBox">
      <div class="container">
        <TopBar />
      <h1>이력서 전체목록(총{{$store.state.resumeCount}}장)</h1>
        <div>
            <li v-for="(resume,index) in $store.state.allResumeList" :key="resume.key">
                <div v-if="index % 4 ==0">
                    <div id="box">
                      <img class="img" src="" alt="">
                      <h1 class="heading">{{ }}</h1>
                      <div class="data">
                        <span class="date">{{ }}</span>
                        <span class="user-id">{{$store.state.allResumeList[index].name }}</span>
                        <span>연락처:{{$store.state.allResumeList[index].phone}}</span>
                        <span>이메일:{{$store.state.allResumeList[index].email}}</span>
                        <span>LinkedIn:{{$store.state.allResumeList[index].socialUrl}}</span>
                        <span>지역:{{$store.state.allResumeList[index].location}}</span>
                        <span>{{$store.state.allResumeList[index+1].institute}}졸업({{$store.state.allResumeList[index+1].startDate}}~{{$store.state.allResumeList[index+1].endDate}})</span>
                        <span>{{$store.state.allResumeList[index+1].faculty}}{{$store.state.allResumeList[index+1].major}}{{$store.state.allResumeList[index+1].degree}}</span>
                        <span>최종학점:{{$store.state.allResumeList[index+1].gpa}}</span>
                        <span v-if="$store.state.allResumeList[index+2].companyName != undefined">{{$store.state.allResumeList[index+2].companyName}}근무({{$store.state.allResumeList[index+2].startDate}}~{{$store.state.allResumeList[index+2].endDate}}/{{$store.state.allResumeList[index+2].position}})</span>
                        <span v-if="$store.state.allResumeList[index+3].skillName != undefined">{{$store.state.allResumeList[index+3].skillName}}취득({{$store.state.allResumeList[index+3].date}})</span>
                      </div>
                      <p class="texts">
                        {{ }}
                      </p>
                    </div>
                </div>
            </li>
        </div>
      </div>
    </section>
    <section class="section2">
      <div class="container">
        <h1>{{ loading }}</h1>

        <!-- 이력서 목록 표시 -->
        <h1>
          채용하기 버튼을 누르면 구직자를 채용한 지원자 페이지에 등록합니다.
        </h1>
        <div></div>
      </div>
      <br />
      <br />
      <br />
      <br />
      <br />
      <br />
    </section>
  </div>
</template>

<script>
import Web3 from "web3";
import ResumeContract from '../../build/contracts/ResumeContract.json';

const contractAddress = process.env.VUE_APP_CONTRACT_ADDRESS
const ethers = require('ethers')
const web3 = new Web3(window.web3.currentProvider)

export default {
  name: "App",
  components: {},
  data() {
      return {
          contractJson: ResumeContract
      }
  },
  methods: {
            async getAllValue(){
                let ResumeContract = new web3.eth.Contract(this.contractJson.abi, contractAddress);
                const addresslist = await ResumeContract.methods.getUsers().call(); 
                const resumeCount = await ResumeContract.methods.resumeCount().call();
                this.$store.state.resumeCount = resumeCount;
                for(let i=0;i<addresslist.length;i++){
                    let personalInfo = await ResumeContract.methods.getPersonalInfo().call({
                        from: addresslist[i] //msg.sender
                    })
                    let education = await ResumeContract.methods.getEducation().call({
                        from: addresslist[i] //msg.sender
                    })
                    let experience = await ResumeContract.methods.getExperience().call({
                        from: addresslist[i] //msg.sender
                    })
                    let skill = await ResumeContract.methods.getSkill().call({
                        from: addresslist[i] //msg.sender
                    })
                    for(let j=0; j<personalInfo.length ;j++){
                        const payload = {
                        //Change Bytes32 type to String type
                            'picUrl': ethers.utils.parseBytes32String(personalInfo[j][0]),
                            'name': ethers.utils.parseBytes32String(personalInfo[j][1]),
                            'phone': ethers.utils.parseBytes32String(personalInfo[j][2]),  
                            'email': ethers.utils.parseBytes32String(personalInfo[j][3]),
                            'dateOfBirth': ethers.utils.parseBytes32String(personalInfo[j][4]),
                            'socialUrl': ethers.utils.parseBytes32String(personalInfo[j][5]),
                            'location': ethers.utils.parseBytes32String(personalInfo[j][6]),
                        }
                        this.$store.commit('setAllResume', payload);
                        const payload2 = {
                            'startDate': ethers.utils.parseBytes32String(education[j][0]),
                            'endDate': ethers.utils.parseBytes32String(education[j][1]),
                            'institute': ethers.utils.parseBytes32String(education[j][2]),  
                            'degree': ethers.utils.parseBytes32String(education[j][3]),
                            'faculty': ethers.utils.parseBytes32String(education[j][4]),
                            'major': ethers.utils.parseBytes32String(education[j][5]),
                            'gpa': ethers.utils.parseBytes32String(education[j][6]),
                        }
                        this.$store.commit('setAllResume', payload2);
                        const payload3 = {
                            'startDate': ethers.utils.parseBytes32String(experience[j][0]),
                            'endDate': ethers.utils.parseBytes32String(experience[j][1]),
                            'companyName': ethers.utils.parseBytes32String(experience[j][2]),  
                            'position': ethers.utils.parseBytes32String(experience[j][3]),
                        }
                        this.$store.commit('setAllResume', payload3);
                        const payload4 = {
                            'skillName': ethers.utils.parseBytes32String(skill[j][0]),
                            'level': ethers.utils.parseBytes32String(skill[j][1]),
                            'date': ethers.utils.parseBytes32String(skill[j][2]),  
                        }
                        this.$store.commit('setAllResume', payload4);                                                
                    }
                }
            },
  },
  created: function(){
      this.$store.commit('initialize');
      this.getAllValue();
  }
};
</script>


<style scoped>
h3 {
  margin-left: 400px;
  margin-top: 100px;
}
a {
  text-decoration: none;
  color: rgb(249, 248, 248);
  font-weight: 600;
}
div {
  box-sizing: border-box;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 200px;
  background-color: #6969bf;
  position: fixed;
  height: 100%;
  overflow: auto;
  z-index: 2;
}
li {
  margin-bottom: 10px;
  margin-right: 20px;
}
.resume1 {
  /* float: center; */
  width: 700px;
  margin-left: 400px;
  background-color: #cbdad4;
}
.resume2 {
  float: center;
  width: 700px;
  margin-left: 400px;
  margin-top: 100px;
  background-color: #cbdad4;
}
.menu ::before {
  font-family: "Material Icons";
  font-size: 1.5em;
  float: left;
  clear: left;
}
.menu label::before {
  content: "\e5d2";
}
.menu li:nth-child(1) a::before {
  content: "\f02e";
}
.menu li:nth-child(2) a::before {
  content: "\e8d6";
}
.menu li:nth-child(3) a::before {
  content: "\e88a";
}
.menu li:nth-child(4) a::before {
  content: "\e8cc";
}
.menu li:nth-child(5) a::before {
  content: "\e87d";
}
.menu li:nth-child(6) a::before {
  content: "\e8b8";
}
#expand-menu {
  /* 체크박스 폼 요소 감춤 */
  display: none;
}
#expand-menu:checked ~ ul {
  /* 체크박스 체크되었으면 메뉴 목록 표시 - 반응형 표시용 */
  display: block;
  height: auto;
}
.menu {
  display: block;
  width: 200px;
  background-color: #000;
  color: #fff;
  border-radius: 20px;
  padding: 0px;
  margin-top: 30px;
  box-sizing: border-box;
  overflow: hidden; /* 반응형 애니메이션용 */
  transition: all 0.5s ease; /* 반응형 애니메이션 */
  float: left;
}
.menu ul {
  list-style: none;
  margin: 0;
  padding: 0;
}
.menu a,
.menu > label {
  display: block;
  height: 25px;
  padding: 8px;
  cursor: pointer;
  color: #fff;
  text-decoration: none;
}
.menu a:hover {
  color: #000;
}
.menu ul li:hover,
.menu > label:hover {
  background-color: #fff;
  color: #000;
  border-radius: 10px;
}
.menu div {
  line-height: 1.5;
  font-size: 1em;
  font-family: "Noto Sans KR";
  padding: 0 0 0 50px; /* 아이콘과 텍스트 사이 여백 */
}
@media screen and (max-width: 1023px) {
  .menu {
    /* 1단계 */
    width: 60px;
  }
}
@media screen and (max-width: 560px) {
  .menu #expand-menu:not(:checked) ~ ul {
    /* 2단계 */
    display: none;
  }
}
.menu div {
  position: absolute; /* 절대 위치로 텍스트 고정 */
  left: 50px;
  line-height: 1.5;
  font-size: 1em;
  font-family: "Noto Sans KR";
  padding: 0 0 0 20px; /* 패딩 20p로 축소 */
}
.btn1 {
  padding: 5px;
  margin: 5px;
  background: black;
  border-radius: 4px;
  color: #275efe;
}
.btn2 {
  padding: 5px;
  margin: 5px;
  background: black;
  border-radius: 4px;
  color: #275efe;
}

/*------------------------------------------------------------*/
body {
  background: linear-gradient(
    90deg,
    #66b6ea,
    #8743ff
  ); /*** 하단 background 컬러 ***/
  color: white;
  margin: 0 0 0 0;
}
li {
  list-style: none;
}
.background {
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  position: fixed;
}
.modal {
  width: 600px;
  height: 800px;
  background: white;
  border-radius: 8px;
  padding: 20px;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.ui.button.mainbutton {
  background: #3d7aed;
  background: linear-gradient(90deg, #66b6ea, #8743ff);
  border-radius: 1.3em;
  box-shadow: 0 10px 30px 2px rgb(159 191 255 / 40%);
  color: #fff;
  font-family: M PLUS rounded\1c, sans-serif;
  font-size: 16px;
  margin: 1em 0;
  min-width: 200px;
  mix-blend-mode: multiply;
}
.ui.button:hover {
  transition: transform 1s;
  filter: brightness(80%);
}
#mainbutton2 {
  background: #3d7aed;
  background: linear-gradient(90deg, #66b6ea, #8743ff);
  border-radius: 1.3em;
  box-shadow: 0 10px 30px 2px rgb(159 191 255 / 40%);
  color: #fff;
  font-family: M PLUS rounded\1c, sans-serif;
  font-size: 16px;
  margin: 1em 0;
  min-width: 200px;
  mix-blend-mode: multiply;
}
#mainbutton2:hover {
  transition: transform 1s;
  filter: brightness(80%);
}
.ui.textbox1 {
  background: transparent;
  border: none;
  border-bottom: 2px solid #66b6ea;
  margin-right: 2cm;
  margin-left: 2cm;
  font-family: "Jua", sans-serif;
  margin-top: 0.35cm;
}
.ui.textbox1:hover {
  transition: transform 1s;
  filter: brightness(90%);
}
.ui.textbox2 {
  background: transparent;
  border: none;
  border-bottom: 2px solid #66b6ea;
  margin-right: 2cm;
  margin-left: 2cm;
  font-family: "Jua", sans-serif;
  margin-top: 0.35cm;
}
.ui.textbox2:hover {
  transition: transform 1s;
  filter: brightness(90%);
}
.ui.textbox3 {
  background: transparent;
  border: none;
  border-bottom: 2px solid #66b6ea;
  margin-right: 2cm;
  margin-left: 2cm;
  font-family: "Jua", sans-serif;
  margin-top: 0.9cm;
}
.ui.textbox3:hover {
  transition: transform 1s;
  filter: brightness(90%);
}
.ui.textbox4 {
  background: transparent;
  border: none;
  border-bottom: 2px solid #66b6ea;
  margin-right: 2cm;
  margin-left: 2cm;
  font-family: "Jua", sans-serif;
  margin-top: 1.2cm;
}
.ui.textbox4:hover {
  transition: transform 1s;
  filter: brightness(90%);
}
.main-all {
  font-family: "Jua", sans-serif;
  position: relative;
  overflow: hidden;
}
.textbox-item {
  display: inline;
}
.left-text {
  text-align: left;
  margin-left: 8cm;
}
.right-text {
  text-align: right;
  margin-right: 8cm;
}
.skewdBox {
  background-image: url("../img/123.png"); /*** 상단 background 컬러 ***/
  color: black;
  padding: 200px 0;
  -webkit-transform: skew(0deg, -10deg);
  -moz-transform: skew(0deg, -10deg);
  -ms-transform: skew(0deg, -10deg);
  -o-transform: skew(0deg, -10deg);
  transform: skew(0deg, -10deg);
  margin-top: -180px; /*** 상단 background 여백높이 ***/
}
.skewdBox .container {
  -webkit-transform: skew(0deg, 10deg);
  -moz-transform: skew(0deg, 10deg);
  -ms-transform: skew(0deg, 10deg);
  -o-transform: skew(0deg, 10deg);
  transform: skew(0deg, 10deg);
  text-align: center;
}
.section2 {
  padding-top: 120px;
  margin-top: -50px; /*** 하단 background 여백높이 ***/
}
.section2 .credits {
  text-align: center;
  color: #666;
}
.section2 .credits .link {
  color: #00b285;
  text-decoration: none;
}
.section2 .container {
  width: 80%;
  margin: 0 auto;
  text-align: center;
}
.titletext {
  color: #031b4e;
  font-size: 2rem;
}
.sidetext {
  color: rgba(149, 149, 150, 0.7);
}
#box {
  width: 300px;
  border-radius: 8px;
  overflow: hidden;
  margin: 100px auto;
  transition: all 0.3s cubic-bezier(0.42, 0, 0.58, 1);
}
#box:hover {
  box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
  transform: translateY(-10px);
}
#box * {
  padding: 10px;
}
#box .img {
  display: block;
  width: 100%;
  padding: 0;
}
#box .heading {
  font-size: 28px;
}
#box .data {
  display: flex;
  flex-direction: column;
  font-size: 12px;
  color: #666;
}
#box .data span {
  padding: 0;
}
#box .data .date {
  margin-bottom: 2px;
}
#box .data .user-id {
  font-size: 16px;
  color: #000;
  font-weight: 600;
}
#box .texts {
  font-size: 14px;
  line-height: 18px;
}
.balloon_01 {
  position: relative;
  margin: 50px;
  width: 400px;
  height: 100px;
  background: pink;
  border-radius: 10px;
}
.balloon_01:after {
  border-top: 0px solid transparent;
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-bottom: 10px solid pink;
  content: "";
  position: absolute;
  top: -10px;
  left: 200px;
}

.balloon_03 {
  position: relative;
  margin: 50px;
  margin-left: 10cm;
  width: 320px;
  height: 250px;
  background: rgba(197, 221, 246, 0.4);
  border-radius: 10px;
}
.balloon_03:after {
  border-top: 15px solid rgba(197, 221, 246, 0.4);
  border-left: 15px solid transparent;
  border-right: 0px solid transparent;
  border-bottom: 0px solid transparent;
  content: "";
  position: absolute;
  top: 10px;
  left: -15px;
}
.balloon_04 {
  position: relative;
  margin: 50px;
  margin-left: 20cm;
  width: 320px;
  height: 250px;
  background: rgba(197, 221, 246, 0.4);
  border-radius: 10px;
}
.balloon_04:after {
  border-top: 15px solid rgba(197, 221, 246, 0.905);
  border-right: 15px solid transparent;
  border-left: 0px solid transparent;
  border-bottom: 0px solid transparent;
  content: "";
  position: absolute;
  top: 10px;
  right: -15px;
}
</style>