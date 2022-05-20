import { createRouter, createWebHistory } from 'vue-router'
import JobSeekerPage from '../views/JobSeekerPage'
import EmployerPage from '../views/EmployerPage'

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
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})


export default router
