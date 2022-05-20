<template>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

<!-- 메인페이지 -->

<div style="overflow:auto" class="main-all">
  <section class="skewdBox">
    <div class="container">
    
    <TopBar/>
    <div class="titletext"> 당신의 이력서를 작성해주세요 </div>
    <div class="sidetext"> MetaMask와 연결을 꼭 확인해주세요 </div>
    <h1 v-if="$store.state.isMetaMaskConnected == true">MetaMask Connected!!</h1>
    <button v-if="$store.state.isMetaMaskConnected == false" @click="connectWallet" class="ui button mainbutton">MetaMask Connection</button>
    <div>
        current address:{{$store.state.address}}
    </div>
    
        <div class="textbox-item">
            <h2 class="left-text">인적사항</h2>
            <div class="balloon_03">
            <div class="text1">
            <input
                v-model="picUrl"
                type="text" 
                placeholder="picUrl"
                class="ui textbox1"
            />
            <input
                v-model="name"
                type="text" 
                placeholder="이름"
                class="ui textbox1"
            />
            <input
                v-model="phone"
                type="text" 
                placeholder="전화번호"
                class="ui textbox1"
            />
            <input
                v-model="email"
                type="text" 
                placeholder="이메일"
                class="ui textbox1"
            />
            <input
                v-model="dateOfBirth"
                type="text" 
                placeholder="생년월일"
                class="ui textbox1"
            />
            <input
                v-model="socialUrl"
                type="text" 
                placeholder="소셜URL"
                class="ui textbox1"
            />
            <input
                v-model="location"
                type="text" 
                placeholder="소재지"
                class="ui textbox1"
            />
            </div>
            </div>
            <h2 class="right-text">학력사항</h2>
            <div class="balloon_04">
            <div class="text2">
            <input
                v-model="startDate_Edu"
                type="text" 
                placeholder="입학연도"
                class="ui textbox2"
            />
            <input
                v-model="endDate_Edu"
                type="text" 
                placeholder="졸업연도"
                class="ui textbox2"
            />
            <input
                v-model="institute"
                type="text" 
                placeholder="학교"
                class="ui textbox2"
            />
            <input
                v-model="degree"
                type="text" 
                placeholder="학위"
                class="ui textbox2"
            />
            <input
                v-model="faculty"
                type="text" 
                placeholder="학부"
                class="ui textbox2"
            />
            <input
                v-model="major"
                type="text" 
                placeholder="전공"
                class="ui textbox2"
            />
            <input
                v-model="gpa"
                type="text" 
                placeholder="학점"
                class="ui textbox2"
            />
            </div>
            </div>
            <h2 class="left-text">경력사항</h2>
            <div class="balloon_03">
            <div class="text3">
            <input
                v-model="startDate_Ex"
                type="text" 
                placeholder="입사연도"
                class="ui textbox3"
            />
            <input
                v-model="endDate_Ex"
                type="text" 
                placeholder="퇴사연도"
                class="ui textbox3"
            />
            <input
                v-model="companyName"
                type="text" 
                placeholder="회사명"
                class="ui textbox3"
            />
            <input
                v-model="position"
                type="text" 
                placeholder="직위"
                class="ui textbox3"
            />
            </div>
            </div>
            <h2 class="right-text">자격증 및 수상 경력</h2>
            <div class="balloon_04">
            <div class="text4">
            <input
                v-model="skillName"
                type="text" 
                placeholder="자격증명"
                class="ui textbox4"
            />
            <input
                v-model="level"
                type="text" 
                placeholder="수준"
                class="ui textbox4"
            />
            <input
                v-model="date"
                type="text" 
                placeholder="취득일자"
                class="ui textbox4"
            />
            </div>
            </div>
        </div>
        <div>
          <br>
          <br>
          
        
            <button class="button is-primary" @click="setValue" id="mainbutton2">이력서 작성</button>
        </div>
      </div>
  </section>
      <section class="section2">
        <div class="container">
        <h1>{{loading}}</h1>
        <!-- 이력서 목록 표시 -->
        <h1>나의 이력서</h1>
        <div v-if="$store.state.resumeList[0] == 'you need to connect MetaMask'">
            메타마스크 지갑 연결을 확인해주세요
        </div>
        <div v-if="$store.state.resumeList[0] == 'you did not write resume yet'">
            아직 이력서를 작성하지 않았습니다
        </div>
        <div>
            <li v-for="(resume,index) in $store.state.resumeList" :key="resume.key">
                <div v-if="index % 4 ==0 && $store.state.isMetaMaskConnected == true">
                    <div id="box">
                      <img class="img" src="" alt="">
                      <h1 class="heading">{{ }}</h1>
                      <div class="data">
                        <span class="date">{{ }}</span>
                        <span class="user-id">{{$store.state.resumeList[index].name }}</span>
                        <span>연락처:{{$store.state.resumeList[index].phone}}</span>
                        <span>이메일:{{$store.state.resumeList[index].email}}</span>
                        <span>LinkedIn:{{$store.state.resumeList[index].socialUrl}}</span>
                        <span>지역:{{$store.state.resumeList[index].location}}</span>
                        <span>{{$store.state.resumeList[index+1].institute}}졸업({{$store.state.resumeList[index+1].startDate}}~{{$store.state.resumeList[index+1].endDate}})</span>
                        <span>{{$store.state.resumeList[index+1].faculty}}{{$store.state.resumeList[index+1].major}}{{$store.state.resumeList[index+1].degree}}</span>
                        <span>최종학점:{{$store.state.resumeList[index+1].gpa}}</span>
                        <span v-if="$store.state.resumeList[index+2].companyName != undefined">{{$store.state.resumeList[index+2].companyName}}근무({{$store.state.resumeList[index+2].startDate}}~{{$store.state.resumeList[index+2].endDate}}/{{$store.state.resumeList[index+2].position}})</span>
                        <span v-if="$store.state.resumeList[index+3].skillName != undefined">{{$store.state.resumeList[index+3].skillName}}취득({{$store.state.resumeList[index+3].date}})</span>
                      </div>
                      <p class="texts">
                        {{ }}
                      </p>
                    </div>
                </div>
                <div v-if="index % 4 == 3">
                    <button @click="[isResumeOpen = true, currentIndex = ((index - 3)/4)]">이력서 수정</button>
                    <button @click="deleteResume">이력서 삭제</button>
                </div>
            </li>
        </div>  
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        
      </section>
      <!-- <h1>이력서 전체목록(총{{$store.state.resumeCount}}장)</h1>
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
        </div>     -->
    </div>

    <!-- 이력서 수정페이지 -->
    <div class="background" v-if="isResumeOpen == true"> 
    <div class="modal" style="overflow: auto">
        <div>
            <div>
                <h2>인적사항</h2>
                <input 
                    :value="$store.state.resumeList[currentIndex*4].picUrl"
                    @input="$store.state.resumeList[currentIndex*4].picUrl = $event.target.value"
                    type="text" 
                    placeholder="picUrl"
                    class="ui modaltextbox1"
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4].name"
                    @input="$store.state.resumeList[currentIndex*4].name = $event.target.value"
                    type="text" 
                    placeholder="name"
                    class="ui modaltextbox1"
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4].phone"
                    @input="$store.state.resumeList[currentIndex*4].phone = $event.target.value"
                    type="text" 
                    placeholder="phone"    
                    class="ui modaltextbox1"            
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4].email"
                    @input="$store.state.resumeList[currentIndex*4].email = $event.target.value"
                    type="text" 
                    placeholder="email"          
                    class="ui modaltextbox1"      
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4].dateOfBirth"
                    @input="$store.state.resumeList[currentIndex*4].dateOfBirth = $event.target.value"
                    type="text" 
                    placeholder="dateOfBirth" 
                    class="ui modaltextbox1"                
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4].socialUrl"
                    @input="$store.state.resumeList[currentIndex*4].socialUrl = $event.target.value"
                    type="text" 
                    placeholder="socialUrl" 
                    class="ui modaltextbox1"              
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4].location"
                    @input="$store.state.resumeList[currentIndex*4].location = $event.target.value"
                    type="text" 
                    placeholder="location"      
                    class="ui modaltextbox1"         
                />
                <br>
                <h2>학력사항</h2>
                <input
                    :value="$store.state.resumeList[currentIndex*4 + 1].startDate"
                    @input="$store.state.resumeList[currentIndex*4 + 1].startDate = $event.target.value"
                    type="text" 
                    placeholder="startDate"       
                    class="ui modaltextbox2"          
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 1].endDate"
                    @input="$store.state.resumeList[currentIndex*4 + 1].endDate = $event.target.value"
                    type="text" 
                    placeholder="endDate"    
                    class="ui modaltextbox2"                 
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 1].institute"
                    @input="$store.state.resumeList[currentIndex*4 + 1].institute = $event.target.value"
                    type="text" 
                    placeholder="institute"  
                    class="ui modaltextbox2"             
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 1].degree"
                    @input="$store.state.resumeList[currentIndex*4 + 1].degree = $event.target.value"
                     type="text" 
                    placeholder="degree"     
                    class="ui modaltextbox2"           
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 1].faculty"
                    @input="$store.state.resumeList[currentIndex*4 + 1].faculty = $event.target.value"
                    type="text" 
                    placeholder="faculty"       
                    class="ui modaltextbox2"          
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 1].major"
                    @input="$store.state.resumeList[currentIndex*4 + 1].major = $event.target.value"
                    type="text" 
                    placeholder="major"        
                    class="ui modaltextbox2"        
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 1].gpa"
                    @input="$store.state.resumeList[currentIndex*4 + 1].gpa = $event.target.value"
                    type="text" 
                    placeholder="gpa"     
                    class="ui modaltextbox2"       
                />
                <br>
                <h2>경력사항</h2>
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 2].startDate"
                    @input="$store.state.resumeList[currentIndex*4 + 2].startDate = $event.target.value"
                    type="text" 
                    placeholder="startDate" 
                    class="ui modaltextbox3"                       
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 2].endDate"
                    @input="$store.state.resumeList[currentIndex*4 + 2].endDate = $event.target.value"
                    type="text" 
                    placeholder="endDate"      
                    class="ui modaltextbox3"   
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 2].companyName"
                    @input="$store.state.resumeList[currentIndex*4 + 2].companyName = $event.target.value"
                    type="text" 
                    placeholder="companyName"    
                    class="ui modaltextbox3"     
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 2].position"
                    @input="$store.state.resumeList[currentIndex*4 + 2].position = $event.target.value"
                    type="text" 
                    placeholder="position"     
                    class="ui modaltextbox3"    
                />
                <br>
                <h2>자격증 및 수상 경력</h2>
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 3].skillName"
                    @input="$store.state.resumeList[currentIndex*4 + 3].skillName = $event.target.value"
                    type="text" 
                    placeholder="skillName"    
                    class="ui modaltextbox4"     
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 3].level"
                    @input="$store.state.resumeList[currentIndex*4 + 3].level = $event.target.value"
                    type="text" 
                    placeholder="level"      
                    class="ui modaltextbox4"  
                />
                <input 
                    :value="$store.state.resumeList[currentIndex*4 + 3].date"
                    @input="$store.state.resumeList[currentIndex*4 + 3].date = $event.target.value"
                    type="text" 
                    placeholder="date"      
                    class="ui modaltextbox4"     
                />
                <br>
                <br>
                <br>
                <br>
                <br>
                <button class="ui button modalbutton" @click="updateResume">이력서 수정</button>
                <button class="ui button modalbutton" @click="resumeClosed">닫기</button>
            </div>
        </div>                   
    </div>    
</div>
</template>

<script lang="js">
    import { onMounted, ref } from '@vue/runtime-core'
    import { useStore } from 'vuex'
    import Web3 from "web3";
    import ResumeContract from '../../build/contracts/ResumeContract.json';
    import TopBar from './TopBar.vue';

    const contractAddress = process.env.VUE_APP_CONTRACT_ADDRESS
    const ethers = require('ethers')
    const web3 = new Web3(window.web3.currentProvider)
    const isMetamaskSupported = ref(false)
    const address = ref("")
    onMounted(()=>{
        isMetamaskSupported.value = typeof window.ethereum !== 'undefined';
    })
    
    export default {
        data() {
            return {
                //PersonalInfo
                picUrl: "",
                name: "",
                phone: "",  
                email: "",
                dateOfBirth: "",
                socialUrl: "",
                location: "",
                //Education
                startDate_Edu: "",
                endDate_Edu: "",
                institute: "",
                degree: "",
                faculty: "",
                major: "",
                gpa: "",
                //Experience
                startDate_Ex: "",
                endDate_Ex: "",
                companyName: "",
                position: "",
                //Skill
                skillName: "",
                level: "",
                date: "",
                //ContractJson
                contractJson: ResumeContract,
                loading: "",
                isResumeOpen: false,
                currentIndex: 0
            };
        },
        components:{TopBar},
        methods: {
            handler() {
                alert('quit browser');
            },
            //이력서 작성 함수
            async setValue() {
                if(this.$store.state.isMetaMaskConnected == false){
                    alert('Connect MetaMask First');
                }
                else{
                    this.loading = 'Transaction request is being processed'
                    let ResumeContract = new web3.eth.Contract(this.contractJson.abi, contractAddress)
                    let contractPersonalInfo = await ResumeContract.methods.addPersonalInfo(
                        //Change String type to Bytes32 type
                        ethers.utils.formatBytes32String(this.picUrl),
                        ethers.utils.formatBytes32String(this.name),
                        ethers.utils.formatBytes32String(this.phone),
                        ethers.utils.formatBytes32String(this.email),
                        ethers.utils.formatBytes32String(this.dateOfBirth),
                        ethers.utils.formatBytes32String(this.socialUrl),
                        ethers.utils.formatBytes32String(this.location))
                    .send({
                        from: this.$store.state.address //msg.sender
                    })
                    let contractEducation = await ResumeContract.methods.addEducation(
                        ethers.utils.formatBytes32String(this.startDate_Edu),
                        ethers.utils.formatBytes32String(this.endDate_Edu),
                        ethers.utils.formatBytes32String(this.institute),
                        ethers.utils.formatBytes32String(this.degree),
                        ethers.utils.formatBytes32String(this.faculty),
                        ethers.utils.formatBytes32String(this.major),
                        ethers.utils.formatBytes32String(this.gpa))
                    .send({
                        from: this.$store.state.address //msg.sender
                    })
                    let contractExperience = await ResumeContract.methods.addExperience(
                        ethers.utils.formatBytes32String(this.startDate_Ex),
                        ethers.utils.formatBytes32String(this.endDate_Ex),
                        ethers.utils.formatBytes32String(this.companyName),
                        ethers.utils.formatBytes32String(this.position))
                    .send({
                        from: this.$store.state.address //msg.sender
                    })
                    let contractSkill = await ResumeContract.methods.addSkill(
                        ethers.utils.formatBytes32String(this.skillName),
                        ethers.utils.formatBytes32String(this.level),
                        ethers.utils.formatBytes32String(this.date))
                    .send({
                        from: this.$store.state.address //msg.sender
                    })                    
                    if (contractPersonalInfo && contractEducation && contractExperience && contractSkill) {
                        this.loading = 'add completed'
                        window.location.reload();
                    }
                }
            },
            async updateResume() {
                let ResumeContract = new web3.eth.Contract(this.contractJson.abi, contractAddress)
                let updatePersonalInfo = await ResumeContract.methods.updatePersonalInfo(
                    //Change String type to Bytes32 type
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].picUrl),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].name),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].phone),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].email),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].dateOfBirth),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].socialUrl),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4].location),this.currentIndex)
                .send({
                    from: this.$store.state.address //msg.sender
                })
                let updateEducation = await ResumeContract.methods.updateEducation(
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].startDate),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].endDate),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].institute),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].degree),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].faculty),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].major),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 1].gpa),this.currentIndex)
                .send({
                    from: this.$store.state.address //msg.sender
                })
                let updateExperience = await ResumeContract.methods.updateExperience(
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 2].startDate),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 2].endDate),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 2].companyName),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 2].position),this.currentIndex)
                .send({
                    from: this.$store.state.address //msg.sender
                })
                let updateSkill = await ResumeContract.methods.updateSkill(
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 3].skillName),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 3].level),
                    ethers.utils.formatBytes32String(this.$store.state.resumeList[this.currentIndex*4 + 3].date),this.currentIndex)
                .send({
                    from: this.$store.state.address //msg.sender
                })                    
                if (updatePersonalInfo && updateEducation && updateExperience && updateSkill) {
                    window.location.reload();
                }
            },
            async deleteResume() {
                let ResumeContract = new web3.eth.Contract(this.contractJson.abi, contractAddress)
                let isResumeDeleted = await ResumeContract.methods.remove(this.currentIndex)
                .send({
                    from: this.$store.state.address //msg.sender
                })
                if(isResumeDeleted){
                    window.location.reload();
                }
            },
            //이력서 가져오기 함수
            async getValue() {
                let ResumeContract = new web3.eth.Contract(this.contractJson.abi, contractAddress)
                if(this.$store.state.isMetaMaskConnected == true){
                    let personalInfo = await ResumeContract.methods.getPersonalInfo().call({
                        from: this.$store.state.address //msg.sender
                    })
                    let education = await ResumeContract.methods.getEducation().call({
                        from: this.$store.state.address //msg.sender
                    })
                    let experience = await ResumeContract.methods.getExperience().call({
                        from: this.$store.state.address //msg.sender
                    })
                    let skill = await ResumeContract.methods.getSkill().call({
                        from: this.$store.state.address //msg.sender
                    })
                    // case 1 : 이력서 작성이 되지 않은 경우
                    if(personalInfo[0] == undefined){
                        const payload = 'you did not write resume yet';
                        this.$store.commit('setResume', payload);
                    }
                    // case 2 : 이력서 작성이 완료된 경우
                    else{
                        for(let i=0; i<personalInfo.length ;i++){
                            const payload = {
                                //Change Bytes32 type to String type
                                'picUrl': ethers.utils.parseBytes32String(personalInfo[i][0]),
                                'name': ethers.utils.parseBytes32String(personalInfo[i][1]),
                                'phone': ethers.utils.parseBytes32String(personalInfo[i][2]),  
                                'email': ethers.utils.parseBytes32String(personalInfo[i][3]),
                                'dateOfBirth': ethers.utils.parseBytes32String(personalInfo[i][4]),
                                'socialUrl': ethers.utils.parseBytes32String(personalInfo[i][5]),
                                'location': ethers.utils.parseBytes32String(personalInfo[i][6]),
                            }
                            const payload2 = {
                                'startDate': ethers.utils.parseBytes32String(education[i][0]),
                                'endDate': ethers.utils.parseBytes32String(education[i][1]),
                                'institute': ethers.utils.parseBytes32String(education[i][2]),  
                                'degree': ethers.utils.parseBytes32String(education[i][3]),
                                'faculty': ethers.utils.parseBytes32String(education[i][4]),
                                'major': ethers.utils.parseBytes32String(education[i][5]),
                                'gpa': ethers.utils.parseBytes32String(education[i][6]),
                            }
                            const payload3 = {
                                'startDate': ethers.utils.parseBytes32String(experience[i][0]),
                                'endDate': ethers.utils.parseBytes32String(experience[i][1]),
                                'companyName': ethers.utils.parseBytes32String(experience[i][2]),  
                                'position': ethers.utils.parseBytes32String(experience[i][3]),
                            }
                            const payload4 = {
                                'skillName': ethers.utils.parseBytes32String(skill[i][0]),
                                'level': ethers.utils.parseBytes32String(skill[i][1]),
                                'date': ethers.utils.parseBytes32String(skill[i][2]),  
                            }
                            this.$store.commit('setResume', payload);
                            this.$store.commit('setResume', payload2);
                            this.$store.commit('setResume', payload3);
                            this.$store.commit('setResume', payload4);
                        }
                    }
                }
                // case 3 : 메타마스크 연결이 되지 않은 경우
                else{
                    const payload = 'you need to connect MetaMask';
                    this.$store.commit('setResume', payload);
                }
            },
            // async getAllValue(){
            //     let ResumeContract = new web3.eth.Contract(this.contractJson.abi, contractAddress);
            //     const addresslist = await ResumeContract.methods.getUsers().call(); 
            //     const resumeCount = await ResumeContract.methods.resumeCount().call();
            //     this.$store.state.resumeCount = resumeCount;
            //     for(let i=0;i<addresslist.length;i++){
            //         let personalInfo = await ResumeContract.methods.getPersonalInfo().call({
            //             from: addresslist[i] //msg.sender
            //         })
            //         let education = await ResumeContract.methods.getEducation().call({
            //             from: addresslist[i] //msg.sender
            //         })
            //         let experience = await ResumeContract.methods.getExperience().call({
            //             from: addresslist[i] //msg.sender
            //         })
            //         let skill = await ResumeContract.methods.getSkill().call({
            //             from: addresslist[i] //msg.sender
            //         })
            //         for(let j=0; j<personalInfo.length ;j++){
            //             const payload = {
            //             //Change Bytes32 type to String type
            //                 'picUrl': ethers.utils.parseBytes32String(personalInfo[j][0]),
            //                 'name': ethers.utils.parseBytes32String(personalInfo[j][1]),
            //                 'phone': ethers.utils.parseBytes32String(personalInfo[j][2]),  
            //                 'email': ethers.utils.parseBytes32String(personalInfo[j][3]),
            //                 'dateOfBirth': ethers.utils.parseBytes32String(personalInfo[j][4]),
            //                 'socialUrl': ethers.utils.parseBytes32String(personalInfo[j][5]),
            //                 'location': ethers.utils.parseBytes32String(personalInfo[j][6]),
            //             }
            //             this.$store.commit('setAllResume', payload);
            //             const payload2 = {
            //                 'startDate': ethers.utils.parseBytes32String(education[j][0]),
            //                 'endDate': ethers.utils.parseBytes32String(education[j][1]),
            //                 'institute': ethers.utils.parseBytes32String(education[j][2]),  
            //                 'degree': ethers.utils.parseBytes32String(education[j][3]),
            //                 'faculty': ethers.utils.parseBytes32String(education[j][4]),
            //                 'major': ethers.utils.parseBytes32String(education[j][5]),
            //                 'gpa': ethers.utils.parseBytes32String(education[j][6]),
            //             }
            //             this.$store.commit('setAllResume', payload2);
            //             const payload3 = {
            //                 'startDate': ethers.utils.parseBytes32String(experience[j][0]),
            //                 'endDate': ethers.utils.parseBytes32String(experience[j][1]),
            //                 'companyName': ethers.utils.parseBytes32String(experience[j][2]),  
            //                 'position': ethers.utils.parseBytes32String(experience[j][3]),
            //             }
            //             this.$store.commit('setAllResume', payload3);
            //             const payload4 = {
            //                 'skillName': ethers.utils.parseBytes32String(skill[j][0]),
            //                 'level': ethers.utils.parseBytes32String(skill[j][1]),
            //                 'date': ethers.utils.parseBytes32String(skill[j][2]),  
            //             }
            //             this.$store.commit('setAllResume', payload4);                                                
            //         }
            //     }
            // },
            //메타마스크 지갑 연결
            async connectWallet() {
            const accounts = await (window).ethereum.request({ method: 'eth_requestAccounts'});
            address.value = accounts[0];
            this.$store.commit('connectMetaMask');
            },
            resumeClosed(){
                this.isResumeOpen = false;
                this.currentIndex = 0;
                window.location.reload();
            }
        },
        watch: {
            // if value changed, reload page
            isValueUpdated: function(newValue){
                if(newValue == true){
                  window.location.reload(true);
                }
            },
        },
        created: function() {
            const store = useStore();
            
            this.$store.commit('initialize');
            this.getValue();
            //this.getAllValue();
            //메타마스크 지갑 변경 감지
            window.ethereum.on('accountsChanged', function (accounts) {
                store.commit('setAddress', accounts[0]);
                console.log('account Changed', accounts[0]);
                window.location.reload();   
                if(store.state.address == undefined) {
                    console.log('account Disconnected');
                    store.commit('setAddress','disconnected');
                    store.commit('disconnectMetaMask')
                }
            });
        }
    };
</script>

<style>
body {  
  background: linear-gradient(90deg,#66b6ea,#8743ff); /*** 하단 background 컬러 ***/  
  color: white;
  margin: 0 0 0 0;
}

li {
    list-style:none;
}
.background {
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    position: fixed;
}
.modal {
    width: 500px;
    height: 750px;
    background: linear-gradient(90deg,#cfecff,#e6d8fe);
    color: #000;
    border-radius: 8px;
    padding: 20px;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1050;
    display: inline-block;
}

.ui.button.mainbutton{
    background: #3d7aed;
    background: linear-gradient(90deg,#66b6ea,#8743ff);
    border-radius: 1.3em;
    box-shadow: 0 10px 30px 2px rgb(159 191 255 / 40%);
    color: #fff;
    font-family: M PLUS Rounded\ 1c,sans-serif;
    font-size: 16px;
    margin: 1em 0;
    min-width: 200px;
    mix-blend-mode: multiply;
}


.ui.button:hover {
  transition: transform 1s;
  filter: brightness(80%);
}

#mainbutton2{
    background: #3d7aed;
    background: linear-gradient(90deg,#66b6ea,#8743ff);
    border-radius: 1.3em;
    box-shadow: 0 10px 30px 2px rgb(159 191 255 / 40%);
    color: #fff;
    font-family: M PLUS Rounded\ 1c,sans-serif;
    font-size: 16px;
    margin: 1em 0;
    min-width: 200px;
    mix-blend-mode: multiply;
}

#mainbutton2:hover {
  transition: transform 1s;
  filter: brightness(80%);
}

.ui.textbox1{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.35cm;
}
.ui.textbox1:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.ui.textbox2{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.35cm;
}
.ui.textbox2:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.ui.textbox3{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.9cm;
}
.ui.textbox3:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.ui.textbox4{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 1.2cm;
}
.ui.textbox4:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.main-all{
  font-family: 'Jua', sans-serif;
  position: relative;
  overflow: hidden;
}

.textbox-item{
  display: inline;
}

.left-text{
  text-align: left;
  margin-left: 8cm;
}

.right-text{
  text-align: right;
  margin-right: 8cm;
}

.skewdBox {  
background-image: url('../img/123.png');/*** 상단 background 컬러 ***/  
color: black;
padding: 200px 0 ;
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
margin-top: -50px; /*** 하단 background 여백높이 ***/}
.section2 .credits {  
text-align: center;  
color: #666;
}
.section2 .credits .link {  
color: #00B285;  
text-decoration: none;
}
.section2 .container {  
width: 80%;  
margin: 0 auto;  
text-align: center;
}

.titletext{
  color: #031b4e;
  font-size: 2rem;
}

.sidetext{
    color: rgba(149, 149, 150, 0.7);
}

#box {
  width: 300px;
  border-radius: 8px;
  overflow: hidden;
  margin: 100px auto;
  transition: all 0.3s cubic-bezier(0.42, 0.0, 0.58, 1.0);
  background: linear-gradient(90deg,#cfe9fb,#e1d2fc);
}

#box:hover {
  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
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
 position:relative;
 margin: 50px;
 width:400px;
 height:100px;
  background:pink;
  border-radius: 10px;
}
.balloon_01:after {
 border-top:0px solid transparent;
 border-left: 10px solid transparent;
 border-right: 10px solid transparent;
 border-bottom: 10px solid pink;
 content:"";
 position:absolute;
 top:-10px;
 left:200px;
}
 
.balloon_03 {
 position:relative;
 margin: 50px;
 margin-left: 10cm;
 width: 320px;
 height:250px;
  background: rgba(197, 221, 246, 0.4);
  border-radius: 10px;

}
.balloon_03:after {
 border-top:15px solid rgba(197, 221, 246, 0.4);;
 border-left: 15px solid transparent;
 border-right: 0px solid transparent;
 border-bottom: 0px solid transparent;
 content:"";
 position:absolute;
 top:10px;
 left:-15px;
}

.balloon_04 {
 position:relative;
 margin: 50px;
 margin-left: 60%;
 width: 320px;
 height:250px;
  background: rgba(197, 221, 246, 0.4);
  border-radius: 10px;
}
.balloon_04:after {
 border-top:15px solid rgba(197, 221, 246, 0.905);;
 border-right: 15px solid transparent;
 border-left: 0px solid transparent;
 border-bottom: 0px solid transparent;
 content:"";
 position:absolute;
 top:10px;
 right:-15px;
}

 .ui.button.modalbutton{
    background: #3d7aed;
    background: linear-gradient(90deg,#66b6ea,#8743ff);
    border-radius: 1.3em;
    box-shadow: 0 10px 30px 2px rgb(159 191 255 / 40%);
    color: #fff;
    font-family: M PLUS Rounded\ 1c,sans-serif;
    font-size: 16px;
    margin: 1em 0;
    min-width: 50px;
    mix-blend-mode: multiply;
    margin-right: 10px;
    margin-left: 10px;
}


.ui.button:hover {
  transition: transform 1s;
  filter: brightness(80%);
}


.ui.modaltextbox1{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.35cm;
}
.ui.modaltextbox1:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.ui.modaltextbox2{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.35cm;
}
.ui.modaltextbox2:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.ui.modaltextbox3{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.35cm;
}
.ui.modaltextbox3:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

.ui.modaltextbox4{
    background: transparent;
    border: none;
    border-bottom: 2px solid #66b6ea;
    margin-right: 2cm;
    margin-left: 2cm;
    font-family: 'Jua', sans-serif;
    margin-top: 0.35cm;
}
.ui.modaltextbox4:hover {
  transition: transform 1s;
  filter: brightness(90%);
}

</style>