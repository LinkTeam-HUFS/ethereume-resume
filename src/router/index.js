import { createRouter, createWebHistory } from 'vue-router'
import JobSeekerPage from '../views/JobSeekerPage'
import EmployerPage from '../views/EmployerPage'
import DidPage from '../views/DidPage.vue'

const routes = [
  {
    path: '/',
    name: 'JobSeekerPage',
    component: JobSeekerPage
  },
  {
    path: '/EmployerPage',
    name: 'EmployerPage',
    component: EmployerPage
  },
  {
    path: '/DidPage',
    name: 'DidPage',
    component: DidPage
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})


export default router
