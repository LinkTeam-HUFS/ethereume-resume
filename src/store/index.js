import { createStore } from 'vuex'
//import router from '../router'
//import { auth } from '../firebase'
/*import { 
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut 
} from 'firebase/auth'
*/
import createPersistedState from 'vuex-persistedstate';

export default createStore({
  state: {
    address: 'disconnected',
    isMetaMaskConnected: false,
    user: null,
    resumeList: [],
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
    initialize(state){
      state.resumeList = [];
    }
  },
  /*actions: {
    async login ({ commit }, details) {
      const { email, password } = details
      try {
        await signInWithEmailAndPassword(auth, email, password)
      } catch (error) {
        switch(error.code) {
          case 'auth/user-not-found':
            alert("이메일/비밀번호를 다시 확인해주세요")
            break
          case 'auth/wrong-password':
            alert("이메일/비밀번호를 다시 확인해주세요")
            break
          default:
            alert("올바른 형식의 이메일/비밀번호를 입력해주세요")
        }
        return
      }
      commit('SET_USER', auth.currentUser)
      router.push('/main')
    },
    async register ({ commit}, details) {
       const { email, password } = details

      try {
        await createUserWithEmailAndPassword(auth, email, password)
      } catch (error) {
        switch(error.code) {
          case 'auth/email-already-in-use':
            alert("이미 존재하는 이메일입니다")
            break
          case 'auth/invalid-email':
            alert("잘못된 이메일입니다")
            break
          case 'auth/operation-not-allowed':
            alert("Operation not allowed")
            break
          case 'auth/weak-password':
            alert("Weak password")
            break
          default:
            alert("이메일/비밀번호를 입력해주세요")
        }
        return
      }

      commit('SET_USER', auth.currentUser)
      router.push('/main')
    },

    async logout ({ commit }) {
      await signOut(auth)
      commit('CLEAR_USER')
      router.push('/')
    },

    fetchUser ({ commit }) {
      auth.onAuthStateChanged(async user => {
        if (user === null) {
          commit('CLEAR_USER')
        } else {
          commit('SET_USER', user)

          if (router.isReady() && router.currentRoute.value.path === '/login') {
            router.push('/')
          }
        }
      })
    }
    
  },
  */
  plugins: [
    createPersistedState()
  ]
})