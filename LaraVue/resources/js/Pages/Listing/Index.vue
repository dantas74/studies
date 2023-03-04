<template>
  <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-2">
    <Listing v-for="listing in listings" :key="listing.id" :listing="listing" />
  </div>
</template>

<script setup>
import Listing from '@/Pages/Listing/Components/Listing.vue'

defineProps({
  listings: Array,
})
</script>

<style scoped>

</style>
