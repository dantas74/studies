<template>
  <form @submit.prevent="submitForm">
    <div class="mb-8 mt-4 flex flex-wrap gap-2">
      <div class="flex flex-nowrap items-center">
        <input
          v-model.number="filterForm.priceFrom"
          class="input-filter-l w-28"
          placeholder="Price from"
          type="text"
        />
        <input
          v-model.number="filterForm.priceTo"
          class="input-filter-r w-28"
          placeholder="Price to"
          type="text"
        />
      </div>
      <div class="flex flex-nowrap items-center">
        <select v-model="filterForm.beds" class="input-filter-l w-28">
          <option :value="null">Beds</option>
          <option v-for="n in 5" :key="n" :value="n">{{ n }}</option>
          <option>6+</option>
        </select>
        <select v-model="filterForm.baths" class="input-filter-r w-28">
          <option :value="null">Baths</option>
          <option v-for="n in 5" :key="n" :value="n">{{ n }}</option>
          <option>6+</option>
        </select>
      </div>
      <div class="flex flex-nowrap items-center">
        <input
          v-model.number="filterForm.areaFrom"
          class="input-filter-l w-28"
          placeholder="Area from"
          type="text"
        />
        <input
          v-model.number="filterForm.areaTo"
          class="input-filter-r w-28"
          placeholder="Area to"
          type="text"
        />
      </div>
      <button class="btn-normal" type="submit">Filter</button>
      <button type="reset" @click="clearForm">Clear</button>
    </div>
  </form>
</template>

<script setup>
import { useForm } from '@inertiajs/vue3'

const props = defineProps({
  filters: Object,
})

const filterForm = useForm({
  priceFrom: props.filters.priceFrom ?? null,
  priceTo: props.filters.priceTo ?? null,
  beds: props.filters.beds ?? null,
  baths: props.filters.baths ?? null,
  areaFrom: props.filters.areaFrom ?? null,
  areaTo: props.filters.areaTo ?? null,
})

const submitForm = () => filterForm.get(route('listing.index'), {
  preserveState: true,
  preserveScroll: true,
})

const clearForm = () => {
  filterForm.priceFrom = null
  filterForm.priceTo = null
  filterForm.beds = null
  filterForm.baths = null
  filterForm.areaFrom = null
  filterForm.areaTo = null
  submitForm()
}
</script>
