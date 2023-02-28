<template>
  <h2>Timer: {{ timer }}</h2>
  <Link href="/">Main page</Link>
  <br />
  <Link href="/hello">Show page</Link>
  <slot>Default Value if no value is provided</slot>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import { ref } from 'vue'

const timer = ref(0)

setInterval(() => timer.value++, 1000)

</script>
