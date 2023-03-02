<template>
  <div>
    <ul>
      <li v-for="listing in listings" :key="listing.id">
        <Link :href="route('listing.show', [listing.id])">
          <ListingAddress :listing="listing" />
        </Link>
        <span style="padding-left: 1em;">
          <Link :href="route('listing.edit', [listing.id])">Edit</Link>
        </span>
        <span style="padding-left: 1em;">
          <Link :href="route('listing.destroy', [listing.id])" as="button" method="DELETE">Delete</Link>
        </span>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import ListingAddress from '@/Components/ListingAddress.vue'

defineProps({
  listings: Array,
})
</script>

<style scoped>

</style>
