<template>
  <form @submit.prevent="register">
    <div class="w-1/2 mx-auto">
      <div>
        <label class="label-form" for="name">Your Name</label>
        <input id="name" v-model="form.name" class="input-form" type="text" />
        <div v-if="form.errors.name" class="input-error">{{ form.errors.name }}</div>
      </div>
      <div class="mt-4">
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
        <label class="label-form" for="password_confirmation">Confirm Password</label>
        <input
          id="password_confirmation" v-model="form.password_confirmation" class="input-form"
          type="password"
        />
        <div v-if="form.errors.password_confirmation" class="input-error">
          {{ form.errors.password_confirmation }}
        </div>
      </div>
      <div class="mt-4">
        <button class="btn-primary w-full" type="submit">Create Account</button>
        <div class="mt-2 text-center">
          <Link :href="route('login')" class="text-sm text">Already have an account? click here</Link>
        </div>
      </div>
    </div>
  </form>
</template>

<script setup>
import { Link, useForm } from '@inertiajs/vue3'

const form = useForm({
  name: null,
  email: null,
  password: null,
  password_confirmation: null,
})

const register = () => form.post(route('user-account.store'))
</script>
