<template>
  <Box>
    <Link :href="route('listing.show', [listing.id])">
      <div class="flex items-center">
        <Price :price="listing.price" class="text-2xl font-bold" />
        <div class="text-xs text-gry-500">
          <Price :price="monthlyPayment" />
          pm
        </div>
      </div>
      <ListingSpace :listing="listing" class="text-lg" />
      <ListingAddress :listing="listing" class="text-gray-500" />
    </Link>
  </Box>
</template>

<script setup>
import { useMonthlyPayment } from '@/Composables/useMonthlyPayment'
import Box from '@/Components/Box.vue'
import Price from '@/Components/Price.vue'
import ListingSpace from '@/Components/ListingSpace.vue'
import ListingAddress from '@/Components/ListingAddress.vue'
import { Link } from '@inertiajs/vue3'

const props = defineProps({
  listing: Object,
})

const { monthlyPayment } = useMonthlyPayment(props.listing.price, 2.5, 25)
</script>

