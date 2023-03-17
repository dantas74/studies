<template>
  <Box>
    <template #header>Make an Offer</template>
    <div>
      <form @submit.prevent="makeOffer">
        <input v-model.number="form.amount" class="input-form" type="text" />
        <input
          v-model.number="form.amount"
          :max="max"
          :min="min"
          class="mt-2 w-full h-4 bg-gray-200 rounded-lg appearance-none cursor-pointer dark:bg-gray-700"
          step="10000"
          type="range"
        />
        <button class="btn-outline w-full mt-2 text-sm" type="submit">
          Make an Offer
        </button>
      </form>
    </div>
    <div class="flex justify-between text-gray-500 mt-2">
      <div>Difference</div>
      <Price :price="difference" />
    </div>
  </Box>
</template>

<script setup>
import Box from '@/Components/Box.vue'
import Price from '@/Components/Price.vue'
import { useForm } from '@inertiajs/vue3'
import { computed, watch } from 'vue'
import { debounce } from 'lodash'

const props = defineProps({
  listingId: Number,
  price: Number,
})

const form = useForm({
  amount: props.price,
})

const makeOffer = () => {
  form.post(route('listing.offer.store', [props.listingId]), {
    preserveScroll: true,
    preserveState: true,
  })
}

const difference = computed(() => form.amount - props.price)
const min = computed(() => Math.round(props.price / 2))
const max = computed(() => Math.round(props.price * 2))

const emit = defineEmits(['offer-updated'])

watch(
  () => form.amount,
  debounce((value) => emit('offer-updated', value), 200),
)
</script>
