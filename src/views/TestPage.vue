<template>
<div style="overflow:auto">
    <h1 v-if="$store.state.isMetaMaskConnected == true">MetaMask Connected!!</h1>
    <button v-if="$store.state.isMetaMaskConnected == false" @click="connectWallet">MetaMask Connection</button>
    <div>
        current address:{{$store.state.address}}
    </div>
    <div class="container">
    ===================================================================================================================================
        <h1>이력서 작성</h1>
        <h2>인적사항</h2>
        <input
            v-model="picUrl"
            type="text" 
            placeholder="picUrl"
        />
        <input
            v-model="name"
            type="text" 
            placeholder="이름"
        />
        <input
            v-model="phone"
            type="text" 
            placeholder="전화번호"
        />
        <input
            v-model="email"
            type="text" 
            placeholder="이메일"
        />
        <input
            v-model="dateOfBirth"
            type="text" 
            placeholder="생년월일"
        />
        <input
            v-model="socialUrl"
            type="text" 
            placeholder="소셜URL"
        />
        <input
            v-model="location"
            type="text" 
            placeholder="소재지"
        />
        <h2>학력사항</h2>
        <input
            v-model="startDate_Edu"
            type="text" 
            placeholder="입학연도"
        />
        <input
            v-model="endDate_Edu"
            type="text" 
            placeholder="졸업연도"
        />
        <input
            v-model="institute"
            type="text" 
            placeholder="학교"
        />
        <input
            v-model="degree"
            type="text" 
            placeholder="학위"
        />
        <input
            v-model="faculty"
            type="text" 
            placeholder="학부"
        />
        <input
            v-model="major"
            type="text" 
            placeholder="전공"
        />
        <input
            v-model="gpa"
            type="text" 
            placeholder="학점"
        />
        <h2>경력사항</h2>
        <input
            v-model="startDate_Ex"
            type="text" 
            placeholder="입사연도"
        />
        <input
            v-model="endDate_Ex"
            type="text" 
            placeholder="퇴사연도"
        />
        <input
            v-model="companyName"
            type="text" 
            placeholder="회사명"
        />
        <input
            v-model="position"
            type="text" 
            placeholder="직위"
        />
        <h2>자격증 및 수상 경력</h2>
        <input
            v-model="skillName"
            type="text" 
            placeholder="자격증명"
        />
        <input
            v-model="level"
            type="text" 
            placeholder="수준"
        />
        <input
            v-model="date"
            type="text" 
            placeholder="취득일자"
        />
        <div>
            <button class="button is-primary" @click="setValue">이력서 작성</button>
        </div>
        <h1>{{loading}}</h1>
        ===================================================================================================================================
        <h1>이력서 목록</h1>
        <div>
            <li v-for="(resume,index) in $store.state.resumeList" :key="resume.key">
                <div v-if="index % 4 ==0 && $store.state.isMetaMaskConnected == true">
                --------------------------------------------------------------------------------------------------------------------
                    <div>-{{(index / 4) + 1}}-</div>
                </div>
                {{$store.state.resumeList[index]}}
                <div v-if="index % 4 == 3">
                    <button>이력서 수정</button>
                </div>
            </li>
        </div>        
    </div>
</div>
</template>

<script lang="js">
    import { onMounted, ref } from '@vue/runtime-core'
    import { useStore } from 'vuex'
    import Web3 from "web3";
    import ResumeContract from '../../build/contracts/ResumeContract.json'

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
            };
        },
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
            //메타마스크 지갑 연결
            async connectWallet() {
            const accounts = await (window).ethereum.request({ method: 'eth_requestAccounts'});
            address.value = accounts[0];
            this.$store.commit('connectMetaMask');
            },
            Test() {
                this.$router.push('/');
            },
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
li {
    list-style:none;
}
</style>