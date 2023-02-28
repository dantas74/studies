<template>
  <h1>Index</h1>
  <Link href="/hello">Show page</Link>
  <div>
    The message is '{{ message }}'
  </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'

defineProps({
  message: String,
})
</script>

<!-- Makes a persistent Layout-->
<!--<script>-->
<!--import MainLayout from "../../Layouts/MainLayout.vue";-->
<!---->
<!--export default {-->
<!--    layout: MainLayout-->
<!--}-->
<!--</script>-->
