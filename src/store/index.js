import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate';

export default createStore({
  state: {
    address: 'disconnected',
    isMetaMaskConnected: false,
    user: null,
    resumeList: [],
    allResumeList: [],
    personalInfo: {
      picUrl: "",
      name: "",
      phone: "",  
      email: "",
      dateOfBirth: "",
      socialUrl: "",
      location: ""
    },
    education: {
      startDate: "",
      endDate: "",
      institute: "",
      degree: "",
      faculty: "",
      major: "",
      gpa: ""
    },
    experience: {
      startDate: "",
      endDate: "",
      companyName: "",
      position: ""
    },
    skill: {
      skillName: "",
      level: "",
      date: ""
    }
  },
  mutations: {
    SET_USER (state, user) {
      state.user = user
    },
    CLEAR_USER (state) {
      state.user = null
    },
    setAddress(state, payload) {
      state.address = payload;
    },
    connectMetaMask(state) {
      state.isMetaMaskConnected = true
    },
    disconnectMetaMask(state) {
      state.isMetaMaskConnected = false
    },
    setResume(state, payload){
      state.resumeList.push(payload);
    },
    setAllResume(state, payload){
      state.allResumeList.push(payload);
    },
    initialize(state){
      state.resumeList = [];
      state.allResumeList = [];
    }
  },
  plugins: [
    createPersistedState()
  ]
})