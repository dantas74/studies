<template>
  <form @submit.prevent="login">
    <div class="w-1/2 mx-auto">
      <div>
        <label class="label-form" for="email">Email (username)</label>
        <input id="email" v-model="form.email" class="input-form" type="email" />
        <div v-if="form.errors.email" class="input-error">{{ form.errors.email }}</div>
      </div>
      <div class="mt-4">
        <label class="label-form" for="password">Password</label>
        <input id="password" v-model="form.password" class="input-form" type="password" />
        <div v-if="form.errors.password" class="input-error">{{ form.errors.password }}</div>
      </div>
      <div class="mt-4">
        <button class="btn-primary w-full" type="submit">Login</button>
        <div class="mt-2 text-center">
          <Link :href="route('user-account.create')" class="text-sm text">Need an account? click here</Link>
        </div>
      </div>
    </div>
  </form>
</template>

<script setup>
import { Link, useForm } from '@inertiajs/vue3'

const form = useForm({
  email: null,
  password: null,
})

const login = () => form.post(route('login.store'))
</script>
