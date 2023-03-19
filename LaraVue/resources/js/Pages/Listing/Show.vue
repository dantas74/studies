<template>
  <div class="flex flex-col-reverse md:grid md:grid-cols-12 gap-4">
    <Box v-if="listing.images.length" class="md:col-span-7 flex items-center w-full">
      <div class="grid grid-cols-2 gap-1">
        <img v-for="image in listing.images" :key="image.id" :alt="image.filename" :src="image.src" />
      </div>
    </Box>
    <EmptyState v-else class="md:col-span-7 flex items-center w-full">No images</EmptyState>
    <div class="md:col-span-5 flex flex-col gap-4">
      <Box>
        <template #header>
          Basic info
        </template>
        <Price :price="listing.price" class="text-2xl font-bold" />
        <ListingSpace :listing="listing" class="text-lg" />
        <ListingAddress :listing="listing" class="text-gray-500" />
      </Box>
      <Box>
        <template #header>
          Monthly Payment
        </template>
        <div>
          <label class="label-form">Interest rate ({{ interestRate }}%)</label>
          <input
            v-model.number="interestRate"
            class="w-full h-4 bg-gray-200 rounded-lg appearance-none cursor-pointer dark:bg-gray-700"
            max="30" min="0.1" step="0.1" type="range"
          />
          <label class="label-form">Duration ({{ duration }} years)</label>
          <input
            v-model.number="duration"
            class="w-full h-4 bg-gray-200 rounded-lg appearance-none cursor-pointer dark:bg-gray-700"
            max="35" min="3" step="1" type="range"
          />
          <div class="text-gray-600 dark:text-gray-200 mt-2">
            <span class="text-gray-400 block">Your monthly payment</span>
            <Price :price="monthlyPayment" class="text-3xl" />
          </div>
          <div class="mt-2 text-gray-500">
            <div class="flex justify-between">
              <div>Total paid</div>
              <div>
                <Price :price="totalPaid" class="font-medium" />
              </div>
            </div>
            <div class="flex justify-between">
              <div>Principal paid</div>
              <div>
                <Price :price="listing.price" class="font-medium" />
              </div>
            </div>
            <div class="flex justify-between">
              <div>Interest paid</div>
              <div>
                <Price :price="totalInterest" class="font-medium" />
              </div>
            </div>
          </div>
        </div>
      </Box>
      <MakeOffer
        v-if="seeMakeOffer"
        :listing-id="listing.id"
        :price="listing.price"
        @offer-updated="offer = $event"
      />
      <OfferMade v-if="offerMade" :offer="offerMade" />
    </div>
  </div>
</template>

<script setup>
import ListingAddress from '@/Components/ListingAddress.vue'
import Price from '@/Components/Price.vue'
import ListingSpace from '@/Components/ListingSpace.vue'
import Box from '@/Components/Box.vue'
import { computed, ref } from 'vue'
import { useMonthlyPayment } from '@/Composables/useMonthlyPayment'
import MakeOffer from '@/Pages/Listing/Components/MakeOffer.vue'
import { usePage } from '@inertiajs/vue3'
import OfferMade from '@/Pages/Listing/Components/OfferMade.vue'
import EmptyState from '@/Components/EmptyState.vue'

const interestRate = ref(2.5)
const duration = ref(25)

const props = defineProps({
  listing: Object,
  offerMade: Object,
})

const offer = ref(props.listing.price)

const { monthlyPayment, totalPaid, totalInterest } = useMonthlyPayment(offer, interestRate, duration)

const seeMakeOffer = computed(
  () => {
    const user = usePage().props.user

    return user && !props.offerMade && user.id !== props.listing.owner_id
  },
)
</script>
