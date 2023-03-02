<template>
  <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-2">
    <Box v-for="listing in listings" :key="listing.id">
      <Link :href="route('listing.show', [listing.id])">
        <Price :price="listing.price" class="text-2xl font-bold" />
        <ListingSpace :listing="listing" class="text-lg" />
        <ListingAddress :listing="listing" class="text-gray-500" />
      </Link>
      <div>
        <Link :href="route('listing.edit', [listing.id])">Edit</Link>
      </div>
      <div>
        <Link :href="route('listing.destroy', [listing.id])" as="button" method="DELETE">Delete</Link>
      </div>
    </Box>
  </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import ListingAddress from '@/Components/ListingAddress.vue'
import Box from '@/Components/Box.vue'
import ListingSpace from '@/Components/ListingSpace.vue'
import Price from '@/Components/Price.vue'

defineProps({
  listings: Array,
})
</script>

<style scoped>

</style>
