<template>
  <div>
    <h3>
      <ListingAddress :listing="listing" />
    </h3>
  </div>
</template>

<script setup>
import ListingAddress from '@/Components/ListingAddress.vue'

defineProps({
  listing: Object,
})
</script>

<style scoped>

</style>
