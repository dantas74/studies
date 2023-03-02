<template>
  <!--  <h2>Timer: {{ timer }}</h2>-->
  <Link href="/listing">Listings</Link>
  <br />
  <Link href="/listing/create">New Listing</Link>
  <div v-if="flashSuccess" class="success">
    {{ flashSuccess }}
  </div>
  <slot>Default Value if no value is provided</slot>
</template>

<script setup>
import { Link, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const flashSuccess = computed(() => usePage().props.flash.success)

// const timer = ref(0)
//
// setInterval(() => timer.value++, 1000)

</script>

<style scoped>
.success {
    background-color: green;
    color: white;
}
</style>
